extends Node

func _ready():
	pass # Replace with function body.

#add effect name, level, duration, who
func new_effect(n, l, d):
	var effectFile = load("res://scripts/effects/effect.gd")
	var e = effectFile.new()
	e.set_name(n)
	e.set_level(l)
	e.set_duration(d)
	return e

func add_effect(e, w):
	w.add_effect(e)

func turn(who):
	print(who.get_effects())
	for e in who.get_effects():
		match e.get_name():
			"r":
				regen(e.get_level(), who)
		e.tick()
		if(e.done == true):
			who.get_effects().erase(e)

func regen(l, w):
	w.heal(0.5 * l, 0)
