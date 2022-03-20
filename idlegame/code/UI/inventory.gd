extends Control

var size = 6
var selected = 0
var selected_color = Color( 1, 1, 1, 1 )
var unselected_color = Color( 0.66, 0.66, 0.66, 1 )

onready var item = get_node("HBoxInventory/Slot1/Vbox/Item")
onready var item2 = get_node("HBoxInventory/Slot2/Vbox2/Item2")
onready var item3 = get_node("HBoxInventory/Slot3/Vbox3/Item3")
onready var item4 = get_node("HBoxInventory/Slot4/Vbox4/Item4")
onready var item5 = get_node("HBoxInventory/Slot5/Vbox5/Item5")
onready var item6 = get_node("HBoxInventory/Slot6/Vbox6/Item6")

func _ready():
	update_color()

func fill():
	item.set_text(create_label(0))
	item2.set_text(create_label(1))
	item3.set_text(create_label(2))
	item4.set_text(create_label(3))
	item5.set_text(create_label(4))
	item6.set_text(create_label(5))

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
		update_color()
	if Input.is_action_pressed("inv_2"):
		you.set_selected(1)
		update_color()
	if Input.is_action_pressed("inv_3"):
		you.set_selected(2)
		update_color()
	if Input.is_action_pressed("inv_4"):
		you.set_selected(3)
		update_color()
	if Input.is_action_pressed("inv_5"):
		you.set_selected(4)
		update_color()
	if Input.is_action_pressed("inv_6"):
		you.set_selected(5)
		update_color()

func get_item(slot):
	var item = you.get_inv_slot(slot)
	return item

func update_color():
	item.add_color_override("font_color", unselected_color)
	item2.add_color_override("font_color", unselected_color)
	item3.add_color_override("font_color", unselected_color)
	item4.add_color_override("font_color", unselected_color)
	item5.add_color_override("font_color", unselected_color)
	item6.add_color_override("font_color", unselected_color)
	match you.get_selected():
		0:
			item.add_color_override("font_color", selected_color)
		1:
			item2.add_color_override("font_color", selected_color)
		2:
			item3.add_color_override("font_color", selected_color)
		3:
			item4.add_color_override("font_color", selected_color)
		4:
			item5.add_color_override("font_color", selected_color)
		5:
			item6.add_color_override("font_color", selected_color)

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
