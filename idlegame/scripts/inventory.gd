extends Control

var size = 6
var selected = 0

func _ready():
	pass

func fill():
	$HBoxInventory/Slot1/Vbox/Item.set_text(create_label(0))
	$HBoxInventory/Slot2/Vbox2/Item2.set_text(create_label(1))
	$HBoxInventory/Slot3/Vbox3/Item3.set_text(create_label(2))
	$HBoxInventory/Slot4/Vbox4/Item4.set_text(create_label(3))
	$HBoxInventory/Slot5/Vbox5/Item5.set_text(create_label(4))
	$HBoxInventory/Slot6/Vbox6/Item6.set_text(create_label(5))

func get_selected():
	return selected

func create_label(slot):
	var item = you.get_inv_slot(slot)
	var label = item.get_name()
	if(item.amount > 1):
		label += " x"
		label += String(item.amount)
	return label

func _process(delta):
	if Input.is_action_pressed("inv_1"):
		you.set_selected(0)
	if Input.is_action_pressed("inv_2"):
		you.set_selected(1)
	if Input.is_action_pressed("inv_3"):
		you.set_selected(2)
	if Input.is_action_pressed("inv_4"):
		you.set_selected(3)
	if Input.is_action_pressed("inv_5"):
		you.set_selected(4)
	if Input.is_action_pressed("inv_6"):
		you.set_selected(5)

func get_item(slot):
	var item = you.get_inv_slot(slot)
	return item

func _on_Slot1_mouse_entered():
	get_tree().call_group("chat", "item_data", get_item(0))

func _on_Slot1_mouse_exited():
	get_tree().call_group("chat", "update_label")

func _on_Slot2_mouse_entered():
	get_tree().call_group("chat", "item_data", get_item(1))

func _on_Slot2_mouse_exited():
	get_tree().call_group("chat", "update_label")

func _on_Slot3_mouse_entered():
	get_tree().call_group("chat", "item_data", get_item(2))

func _on_Slot3_mouse_exited():
	get_tree().call_group("chat", "update_label")

func _on_Slot4_mouse_entered():
	get_tree().call_group("chat", "item_data", get_item(3))

func _on_Slot4_mouse_exited():
	get_tree().call_group("chat", "update_label")

func _on_Slot5_mouse_entered():
	get_tree().call_group("chat", "item_data", get_item(4))

func _on_Slot5_mouse_exited():
	get_tree().call_group("chat", "update_label")

func _on_Slot6_mouse_entered():
	get_tree().call_group("chat", "item_data", get_item(5))

func _on_Slot6_mouse_exited():
	get_tree().call_group("chat", "update_label")
