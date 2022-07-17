extends Node

func make_sword(n, dmg):
	var swordFile = load("res://code/items/sword.gd")
	var sword = swordFile.new()
	sword.set_name(n)
	sword.set_damage(dmg)
	return sword

func make_bow(n, dmg):
	var bowFile = load("res://code/items/bow.gd")
	var bow = bowFile.new()
	bow.set_name(n)
	bow.set_damage(dmg)
	return bow

func empty_slot():
	var itemFile = load("res://code/items/item.gd")
	var item = itemFile.new()
	item.set_name("empty")
	item.set_damage(1)
	return item

func default_sword():
	var swordFile = load("res://code/items/sword.gd")
	var sword = swordFile.new()
	sword.set_name("Iron Sword")
	sword.set_damage(5.5)
	return sword

func default_bow():
	var bowFile = load("res://code/items/bow.gd")
	var bow = bowFile.new()
	bow.set_name("Bow")
	bow.set_damage(4)
	return bow
