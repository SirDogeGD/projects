extends Node2D

var xpboostcost = 0
var gboostcost = 0
var dmgboostcost = 0
var defboostcost = 0
var elgatocost = 0
var maxupgrade = 5

func _ready():
	update_labels()

func update_labels():
	set_costs("xpboost")
	set_costs("gboost")
	set_costs("dmgboost")
	set_costs("defboost")
	set_costs("elgato")
	$C1/CLabel/LabelGold.set_text("Gold: " + String(stats.gold))
	$C1/ShopItems/XPBoost/XPBoostButton.set_text(String(xpboostcost))
	$C1/ShopItems/GBoost/GBoostButton.set_text(String(gboostcost))
	$C1/ShopItems/DmgBoost/DmgBoostButton.set_text(String(dmgboostcost))
	$C1/ShopItems/DefBoost/DefBoostButton.set_text(String(defboostcost))
	$C1/ShopItems/Elgato/ElgatoButton.set_text(String(elgatocost))
	$C1/ShopItems/XPBoost/Label.set_text("XP Boost: +" + String(you.upgrades["xpboost"]) + "0%")
	$C1/ShopItems/GBoost/Label.set_text("Gold Boost: +" + String(you.upgrades["gboost"]) + "0%")
	$C1/ShopItems/DmgBoost/Label.set_text("Dmg Boost: +" + String(you.upgrades["dmgboost"]) + "%")
	$C1/ShopItems/DefBoost/Label.set_text("Armor: +" + String(you.upgrades["defboost"]))
	$C1/ShopItems/Elgato/Label.set_text("First kills Boost: +" + String(you.upgrades["elgato"]))

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/camp.tscn")

#updates costs of upgrades based on what tier the user has currently.
func set_costs(what):
	var price = "max"
	match int(you.upgrades[what]):
		0:
			price = 200
		1:
			price = 500
		2:
			price = 1500
		3:
			price = 4000
		4:
			price = 10000
		5:
			price = "max"
	match what:
		"xpboost":
			xpboostcost = price
		"gboost":
			gboostcost = price
		"dmgboost":
			dmgboostcost = price
		"defboost":
			defboostcost = price
		"elgato":
			elgatocost = price

func buy(what):
	var dict_key
	var cost_var
	var upgrade_var
	match what:
		"xp":
			dict_key = "xpboost"
			cost_var = xpboostcost
			upgrade_var = "xp"
		"g":
			dict_key = "gboost"
			cost_var = gboostcost
			upgrade_var = "g"
		"dmg":
			dict_key = "dmgboost"
			cost_var = dmgboostcost
			upgrade_var = "dmg"
		"def":
			dict_key = "defboost"
			cost_var = defboostcost
			upgrade_var = "def"
		"el":
			dict_key = "elgato"
			cost_var = elgatocost
			upgrade_var = "el"
	if(int(you.upgrades[dict_key]) < maxupgrade):
		if(stats.gold >= cost_var):
			you.upgrade(upgrade_var)
			stats.add_stats("g", -cost_var)
			update_labels()
		else:
			pass
	else:
		pass

func _on_XPBoostButton_pressed():
	buy("xp")

func _on_GBoostButton_pressed():
	buy("g")

func _on_DmgBoostButton_pressed():
	buy("dmg")

func _on_DefBoostButton_pressed():
	buy("def")

func _on_ElgatoButton_pressed():
	buy("el")
