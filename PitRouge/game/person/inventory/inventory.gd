extends Node
class_name inventory

var size = 8
var selected = 0
var items : Array[PackedScene]

func clear_inv():
	items.clear()
	items.resize(9)
	for i in items.size():
		items[i] = preload("res://game/item/item.tscn")
	items[0] = preload("res://game/item/weapon/melee/sword/sword.tscn")

func add(new: item):
	items.append(new)

func scroll(up : bool):
	if up:
		selected += 1 if selected < size else 0
	else:
		selected -= 1 if selected > 0 else 8

func select(num : int):
	num = clamp(num, 0, size)
	selected = num
