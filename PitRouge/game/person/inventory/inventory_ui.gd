extends Node
class_name inventory_ui

@onready var pan = $Panel

func update_slots(i : inventory):
	for n in pan.get_child_count():
		pan.get_child(n).update_slot(i)
