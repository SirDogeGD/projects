extends MarginContainer
class_name perk_slot_one

var id : String = "EMPTY"
var lvl : int

func update():
	if id != "EMPTY":
		%Level.text = str(lvl)
	%Pic.texture = PINFO.get_pic(id)