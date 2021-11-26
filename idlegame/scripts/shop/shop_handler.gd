extends Node

var purchases = []

func _ready():
	pass

func get_purchases():
	return purchases

func add_purchase(p):
	purchases.append(p)
