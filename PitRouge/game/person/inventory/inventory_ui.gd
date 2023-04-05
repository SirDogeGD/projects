extends Node
class_name inventory_ui

func _ready():
	pass

func update_slots(i : inventory):
	for n in get_child_count():
		get_child(n).update_slot(i)
