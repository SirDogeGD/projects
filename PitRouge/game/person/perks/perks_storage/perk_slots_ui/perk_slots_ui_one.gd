extends MarginContainer
class_name perk_slot_one

var id : String = "EMPTY"
var lvl : int

func _ready():
	mouse_entered.connect(PUI.update_tooltip.bind(id, lvl, true))
	mouse_exited.connect(PUI.update_tooltip.bind(id, lvl, false))

func update():
	if id != "EMPTY":
		%Level.text = str(lvl)
	%Pic.texture = PINFO.get_pic(id)
