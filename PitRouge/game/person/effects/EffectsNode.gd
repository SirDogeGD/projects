extends Node2D
class_name effects
#adds effect children with timer

signal effects_changed(e : Dictionary)

#counter for current effects
var active := {
	"SPEED" : 0,
	"STRENGTH" : 0,
	"RES" : 0,
	"REG" : 0
	}

func _ready():
	pass
	#add_effect("RES", 50)

func add_effect(type : String, dura : float, from := "self"):
	var effect_scene = preload("res://game/person/effects/effect.tscn")
	var new_effect = effect_scene.instantiate()
	var dura_mult := 1.0
	
	new_effect.TYPE = type
	new_effect.FROM = from
	
	#duration
	if owner is person:
		dura_mult *= owner.mega_stats.effect_dura
	new_effect.TIME.wait_time = dura * dura_mult
	
	#perm effect
	if dura == 0:
		new_effect.TIME.autostart = false
	
	add_child(new_effect)
	
	new_effect.TIME.timeout.connect(remove_effect.bind(new_effect.TYPE))
	
	#add to active
	if active.has(type):
		active[type] += 1
	else:
		active[type] = 1
	emit_signal("effects_changed", active)

#remove from active
func remove_effect(type):
	active[type] = max(0, active[type] - 1)
	emit_signal("effects_changed", active)

#remove all effects from active
func clear_effect(type):
	for e : effect in get_children():
		if e.TYPE == type:
			e.queue_free()
	active[type] = 0
	emit_signal("effects_changed", active)

func get_boost(type : String) -> float:
	match type:
		"SPEED":
			return active[type] * 3
		"RES":
			return 1.0 - float(active[type]) / 50 #1 resistance = 2% dmg reduction
		"STRENGTH":
			return float(active[type]) / 20 #1 strength = 5% more dmg
		_:
			if active.has(type):
				return float(active[type])
			return 0
