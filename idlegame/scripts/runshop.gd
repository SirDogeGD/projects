extends Node2D

var itemFile = preload("res://scenes/shop/shopitem.tscn")

func _ready():
	stock()
	shop_handler.runshop_stock()
	$VBox/GStatShower.type("g")

func _on_ContinueB_pressed():
	scene_handler.next_scene()

#				replace iron sword with diamond sword
#				for i in you.inv:
#					var sword = load("res://scripts/items/sword.gd")
#					if you.inv[i].get_script() == sword:
#						you.inv[i] = item_creator.make_sword("Diamond Sword", 6)


func stock():
	var items = []
	for id in shop_handler.runshop_stock():
		items.append(make(id))
	for n in items:
		$VBox/ShopItems.add_child(n)

func make(what):
	var item = itemFile.instance()
	var state = 1
	var perk = perk_info.perkinfo(what)
	var price = set_price(what)
	item.setup(price, perk.get_name(), perk.get_desc(), state, ["runshop", what])
	return(item)

func set_price(what):
	match what:
		6:
			return 300
		7:
			return 500
		8:
			return 200
