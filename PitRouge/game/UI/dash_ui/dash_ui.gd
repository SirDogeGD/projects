extends HBoxContainer

var slot = preload("res://game/UI/dash_ui/dash_ui_slot.tscn")

func update_slots(max : int, left : int):
	for n in get_children():
		remove_child(n)
		n.queue_free()
	for n in range(max):
		var new_slot : dash_ui_slot = slot.instantiate()
		if left <= n:
			new_slot.empty()
			pass
		add_child(new_slot)
