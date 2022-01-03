extends Node2D

var itemFile = preload("res://code/shop/shopitem.tscn")

func _ready():
	stock()
	$VBoxContainer/HBoxContainer/StatShower.type("g")

func _on_BBack_pressed():
	get_tree().change_scene("res://code/shop/shop.tscn")

func stock():
	var items = []
	items.append(make("overdrive"))
	if 2 in stats.pUpgrades:
		items.append(make("beastmode"))
	for n in items:
		$VBoxContainer/GridContainer.add_child(n)

func make(mega):
	var item = itemFile.instance()
	var selected = you.get_mega()
	var state = 1
	match mega:
		"overdrive":
			state = 2
			item.setup(0, "Overdrive", "10 kills\n+4k xp on death", state, ["mega", "overdrive"])
		"beastmode":
			item.setup(10000, "Beastmode", "20 kills\n+25% dmg", state, ["mega", "beastmode"])
	return(item)
