extends MarginContainer

var slot := preload("res://game/UI/effects_ui/effects_ui_one.tscn")

func update(e : Dictionary):
	for c in %effectsContainer.get_children():
		c.free()
	
	for ef in e.keys():
		if e[ef] > 0:
			var euo := slot.instantiate()
			euo.eff = ef
			euo.lvl = e[ef]
			%effectsContainer.add_child(euo)
			euo.update()
