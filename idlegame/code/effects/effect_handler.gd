extends Node

func _ready():
	pass # Replace with function body.

#add effect name, level, duration
func new_effect(n, l, d):
	var effectFile = load("res://code/effects/effect.gd")
	var e = effectFile.new()
	e.set_name(n)
	e.set_level(l)
	e.set_duration(d)
	return e

func add_effect(new, w : guy):
	var effects = w.effects
	if effects.empty():
		w.add_effect(new)

	for e in effects:
		if e.get_name() == new.get_name():
			if e.get_level() < new.get_level():
				effects.erase(e)
				w.add_effect(new)
			else:
				if e.get_duration() < new.get_duration() and e.get_level() == new.get_level():
					effects.erase(e)
					w.add_effect(new)

func turn(who : guy):
	var effects = who.effects
	for e in effects:
#		print(e.get_name())
		match e.get_name():
			"r":
				regen(e.get_level(), who)
		e.tick()
		if(e.done == true):
			effects.erase(e)
		
		update_effects(who)
	
#	send effect list and person to effect_show_containers
func update_effects(who : guy):
	var effects = who.effects
	var you_script = load("res://code/player/you.gd")
	var enemy_script = load("res://code/player/enemy.gd")
	match who.get_script():
		you_script:
			get_tree().call_group("effectshow", "update_effects", "you", effects)
		enemy_script:
			get_tree().call_group("effectshow", "update_effects", "enemy", effects)

func regen(l, w):
	w.heal(0.5 * l, 0)
