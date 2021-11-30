extends Node

func _ready():
	pass # Replace with function body.

#add effect name, level, duration
func new_effect(n, l, d):
	var effectFile = load("res://scripts/effects/effect.gd")
	var e = effectFile.new()
	e.set_name(n)
	e.set_level(l)
	e.set_duration(d)
	return e

func add_effect(new, w):
	if w.get_effects().empty():
		w.add_effect(new)

	for e in w.get_effects():
		if e.get_name() == new.get_name():
			if e.get_level() < new.get_level():
				w.get_effects().erase(e)
				w.add_effect(new)
			else:
				if e.get_duration() < new.get_duration() and e.get_level() == new.get_level():
					w.get_effects().erase(e)
					w.add_effect(new)

func turn(who):
	for e in who.get_effects():
		match e.get_name():
			"r":
				regen(e.get_level(), who)
		e.tick()
		if(e.done == true):
			who.get_effects().erase(e)

func regen(l, w):
	w.heal(0.5 * l, 0)
