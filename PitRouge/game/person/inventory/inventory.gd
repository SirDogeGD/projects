extends Node
class_name inventory

var items : Array[item]

func add(new: item):
	items.append(new)
