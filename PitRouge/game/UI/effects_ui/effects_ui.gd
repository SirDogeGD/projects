extends MarginContainer

var slot := preload("res://game/UI/effects_ui/effects_ui_one.tscn")

var connected_person : person:
	set(p):
		# Disconnect from old person
		if connected_person and connected_person.effect_node:
			if connected_person.effect_node.effects_changed.is_connected(_on_effects_changed):
				connected_person.effect_node.effects_changed.disconnect(_on_effects_changed)
		connected_person = p
		# Connect to new person
		if connected_person and connected_person.effect_node:
			connected_person.effect_node.effects_changed.connect(_on_effects_changed)
			_on_effects_changed(connected_person.effect_node.active)

func _on_effects_changed(e : Dictionary):
	for c in %effectsContainer.get_children():
		c.queue_free()
	
	if connected_person:
		
		for ef in e:
			if e[ef] > 0:
				var euo := slot.instantiate()
				euo.eff = ef
				euo.lvl = e[ef]
				%effectsContainer.add_child(euo)
				euo.update()
