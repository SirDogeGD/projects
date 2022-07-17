extends Node
class_name guy

signal health_changed(hp, max_hp, shield)
signal effects_changed(effects)

var hp := 20
var current_hp := 20 setget set_hp, get_hp
var current_shield := 0
var armor := 10
var streak := 0
var is_player := true

#dmg stuff
var first_strike := true
var dmg = 0
var base = 0
var mult = 100
var crit_mult = 120
#var trumult
var tru = 0
var next_crit := false #Next turn will spawn a crit marker
var crit := false      #Crit marker pressed
var cc := 5

var invsize = 6
var inv = {}
var heal_perk = "gap"
var perks = []
var effects = [] 
var upgrades = {
	"xpboost":0,
	"gboost":0,
	"dmgboost":0,
	"defboost":0,
	"elgato":0,
	"purchases":[],
	"selected_mega":mega
}

#megastreak variables (dmg taken, resource rewards)
onready var mega = stats.load_Stats()["Upgrades"]["selected_mega"]
var mactive = false
var mtd : float = 0
var md : float = 0
var mgb : float = 0
var mxpb : float = 0
var mdb : float = 0

func _ready():
	pass

func set_hp(new_hp):
	current_hp = min(new_hp, hp)
	emit_signal("health_changed", current_hp, hp, current_shield)

func get_hp():
	return current_hp

func get_armor():
	var def = armor
	def += int(upgrades["defboost"])
	return def

func set_armor(a):
	armor = a + 5

func get_shield():
	return current_shield

func create_empty_inv():
	var empty = {}
	for n in range(invsize):
		empty[n] = item_creator.empty_slot()
	inv = empty

func get_inv_slot(w):
	return inv[w]

func upgrade(what):
	var xpboost = upgrades["xpboost"]
	var gboost = upgrades["gboost"]
	var dmgboost = upgrades["dmgboost"]
	var defboost = upgrades["defboost"]
	var elgato = upgrades["elgato"]
	match what:
		"xp":
			xpboost += 1
		"g":
			gboost += 1
		"dmg":
			dmgboost += 1
		"def":
			defboost += 1
		"el":
			elgato += 1
	
	upgrades["xpboost"] = xpboost
	upgrades["gboost"] = gboost
	upgrades["dmgboost"] = dmgboost
	upgrades["defboost"] = defboost
	upgrades["elgato"] = elgato

func get_upgrades():
	upgrades["purchases"] = shop_handler.get_purchases()
	upgrades["selected_mega"] = mega
	return self.upgrades

func add_to_inv(item):
	var is_added = false
	for n in range(invsize):
		if(is_added == false):
			if(inv[n].get_name() == "empty"):
				inv[n] = item
				is_added = true
			else:
				if(inv[n].get_name() == item.get_name()):
					if(inv[n].get_ssize() >= 1):
						inv[n].amount += 1
						is_added = true

func heal(h, s):
	set_hp(current_hp + h)
	current_shield += s

func consume_item():
	var item = you.get_inv_slot(you.get_selected())
	item.amount -= 1
	if(item.amount == 0):
		inv[you.get_selected()] = item_creator.empty_slot()

func random_hp():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	self.current_hp = rng.randf_range(self.hp/2, self.hp)

func add_effect(e):
	effects.append(e)
	emit_signal("effects_changed", effects)
	
func clear_effects():
	effects.clear()
	emit_signal("effects_changed", effects)

#updates the megastreak variables based on the current streak
func update_megas():
	var arr = megastreak_handler.get_all(self, streak)
	mtd = arr[0]
	md = arr[1]
	mgb = arr[2]
	mxpb = arr[3]
	mdb = arr[4]

#reset stats that get altered during fight calculation
func reset_fight():
	dmg = 0
	base = 0
	mult = 100
	crit_mult = 120
	tru = 0
	crit = false
	cc = 5
	armor = 10
