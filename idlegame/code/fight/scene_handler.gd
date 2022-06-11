extends Node

var count = 0
var last_minor = 0
var perks = 0
var run_g = 0
var run_xp = 0
var run_dmg = 0

var rng = RandomNumberGenerator.new()

#fight scenes
var fight = "res://code/fight/fight.tscn"
var pc = "res://code/perks/perk_choose.tscn"
var qm = "res://code/events/quickmath/quickmath.tscn"
var rs = "res://code/shop/runshop.tscn"
var cc = "res://code/events/contract/contract.tscn"

#various scenes
var main_menu = "res://code/places/main.tscn"
var camp = "res://code/places/camp.tscn"
var shop = "res://code/shop/shop.tscn"
var megashop = "res://code/shop/mega shop.tscn"
var prestige = "res://code/prestige/prestige.tscn"
var prestigeshop = "res://code/prestige/prestigeShop.tscn"
var deathscreen = "res://code/UI/deathscreen/deathscreen.tscn"

#pause menu stuff
var pauseMenu = "res://code/UI/pauseMenu/PauseMenu.tscn"
var pauseMenuFile = preload("res://code/UI/pauseMenu/PauseMenu.tscn")
var pm

#transition
var transition = preload("res://code/events/transition/transition.tscn")
var ttext

func _ready():
	self.set_pause_mode(PAUSE_MODE_PROCESS)

#switch to scene s
func scene(s):
	match s:
		pauseMenu:
			if not get_tree().paused:
#				pause fight scenes
				get_tree().paused = true
				pm = pauseMenuFile.instance()
				get_tree().root.add_child(pm)
				pm.z_index = 1000
			else:
#				unpause fight scenes
				get_tree().paused = false
				get_tree().root.remove_child(pm)
		_:
			get_tree().change_scene(s)

func next_scene():
	if(count == 0):
		count += 1
		scene(pc)
	elif(is_minor()):
		count += 1
		what_minor()
	else:
		count += 1
		scene(fight)
		you.first_strike = true

func is_perk():
	var extra_perks = 0
	var extra_perks_id = [1, 6]
	for id in extra_perks_id:
		if id in stats.pUpgrades:
			extra_perks += 1
	if(perks < extra_perks):
		perks += 1
		return true
	else:
		return false

func reset():
	count = 0
	perks = 0
	run_g = 0
	run_xp = 0
	run_dmg = 0

func is_minor():
	rng.randomize()
	var chance = rng.randi_range(1,70)
	if(chance <= 5 and last_minor >= 10):
		last_minor = 0
		return true
	last_minor += 1
	return false

func what_minor():
	rng.randomize()
	var which = rng.randi_range(0,3)
	match which:
		0:
			if is_perk():
				scene(pc)
				ttext = "Perk Choice"
			else:
				what_minor()
		1:
			scene("res://code/shop/runshop.tscn")
			ttext = "Shop"
		2:
			scene("res://code/events/quickmath/quickmath.tscn")
			ttext = "Quick Maths"
		3:
			scene("res://code/events/contract/contract.tscn")
			ttext = "Contract"
	
	transition_scene(ttext)

func _process(delta):
#	handle pressing escape
	if Input.is_action_just_pressed("ui_cancel"):
		match get_tree().current_scene.filename:
			fight, pc, qm, rs, cc:
				scene(pauseMenu)
			shop:
				scene(camp)
			megashop:
				scene(shop)
			prestige:
				scene(camp)
			prestigeshop:
				scene(prestige)
			deathscreen:
				scene(camp)

#die and go back to spawn
func deathscreen():
	scene(deathscreen)
	
func death():
	you.death()
	if get_tree().paused:
		get_tree().paused = false
		get_tree().root.remove_child(pm)
	scene_handler.reset()

func transition_scene(tt):
	get_tree().paused = true
	var t = transition.instance()
	t.set_text(tt)
	get_tree().root.add_child(t)
	t.z_index = 1000
