extends VBoxContainer

func update():
#	remove labels
	for c in get_children():
		c.queue_free()
		
#	add labels
	for r in GameState.resources:
		if GameState.resources.get(r) > 0:
			var mylabel = resources_label.new()
			mylabel.my_type = r
			mylabel.add_to_group("%s_counter" % r)
			add_child(mylabel)
			mylabel.update()
