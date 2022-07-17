extends Node

var purchases = []

func _ready():
	pass

func get_purchases():
	return purchases

func add_purchase(p):
	purchases.append(p)

#gives runshop a list of items it should stock
func runshop_stock():
	var all = [6, 7, 8]
	var unbought = []
	for x in all.size():
		if not all[x] in you.perks:
			unbought.append(all[x])
	return unbought
