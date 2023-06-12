extends Node

var playersave : save_data

func _enter_tree():
	load_data()

func load_data():
	if ResourceLoader.exists("user://save.res"):
		var saved = ResourceLoader.load("user://save.res")
		if saved is save_data:
			playersave = saved

func save_data():
	var result = ResourceSaver.save(playersave, "user://save.res")
	assert(result == OK)
