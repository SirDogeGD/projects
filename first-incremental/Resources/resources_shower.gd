extends VBoxContainer

func update():
#	remove labels
	for c in get_children():
		c.queue_free()
		 
#	add labels
	for t in GameState.types:
		var n = GameState.get_name_of_type(GameState.types[t])
		if GameState.get_resource(n) > 0:
			var mylabel = resources_label.new()
			mylabel.type = GameState.types[t]
			mylabel.add_to_group("%s_counter" % n)
			add_child(mylabel)
			mylabel.update()
