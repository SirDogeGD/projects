extends Node2D

var itemFile = preload("res://scenes/shop/shopitem.tscn")

func _ready():
	stock()
	update()
	$VBoxContainer/HBoxContainer/StatShower.type("g")

func _on_BBack_pressed():
	get_tree().change_scene("res://scenes/shop/shop.tscn")

func stock():
	var items = []
	items.append(make("o"))
	if 2 in stats.pUpgrades:
		items.append(make("b"))
	for n in items:
		$VBoxContainer/GridContainer.add_child(n)

func make(mega):
	var item = itemFile.instance()
	var selected = you.get_mega()
	var p = 0
	var state = 1
	match mega:
		"o":
			if selected == "od":
				p = "selected"
				state = 3
			item.setup(p, "Overdrive", "add later", state, ["m", "od"])
		"b":
			p = 10000
			if selected == "b":
				p = "selected"
			item.setup(p, "Beastmode", "add later", state, ["m", "b"])
	return(item)
