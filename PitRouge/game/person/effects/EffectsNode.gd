extends Node2D
class_name effects
#adds effect children with timer

#counter for current effects
var active = {
	"SPEED" : 0,
	"STRENGTH" : 0,
	"RES" : 0,
	"REG" : 0
	}

func _ready():
	add_effect("SPEED", "test", 5)

func add_effect(type, from, dura):
	var effect_scene = preload("res://game/person/effects/effect.tscn")
	var new_effect = effect_scene.instantiate()
	new_effect.TYPE = type
	new_effect.FROM = from
	new_effect.TIME.wait_time = dura
	add_child(new_effect)
	
	new_effect.TIME.timeout.connect(remove_effect.bind(new_effect.TYPE))
	
	#add to active
	active[type] += 1

#remove from active
func remove_effect(type):
	active[type] = max(0, active[type] - 1)

func get_boost(type : String) -> int:
	match type:
		"SPEED":
			return active[type] * 2
		"RES":
			return 1 - active[type] / 50 #1 resistance = 2% dmg reduction
		_:
			return active[type]
