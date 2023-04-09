extends Control
class_name inv_slot

@export var which_slot_am_i := 0

@onready var pic = $Sprite2D
@onready var sel_frame = $SelectedFrame

var selected := false

func update_slot(i : inventory):
	var Sitem = i.items[which_slot_am_i].instantiate()
	pic.texture = Sitem.get_pic()
	selected = (i.selected == which_slot_am_i)
	sel_frame.update_img(selected)
