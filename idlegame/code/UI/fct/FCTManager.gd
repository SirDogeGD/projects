extends Node2D

var FCT = preload("res://code/UI/fct/FCT.tscn")

@export var travel = Vector2(0, -80)
@export var duration = 2
@export var spread = PI/2

func show_value(value, type="DMG"):
	if typeof(value) == TYPE_FLOAT:
		if value > 0:
			value = snapped(value,0.01)
		else:
			return #if dmg = 0, dont show
	var fct = FCT.instantiate()
	add_child(fct)
	fct.show_value(str(value), travel, duration, spread, type)
