extends VBoxContainer

func update():
#	remove labels
	for c in get_children():
		c.queue_free()
		
#	add labels
	for r in GameState.resources:
		if GameState.resources.get(r) > 0:
			var label = resources_label.new()
			label.my_type = r
			add_child(label)
			#print(r, ': ', GameState.resources.get(r))
