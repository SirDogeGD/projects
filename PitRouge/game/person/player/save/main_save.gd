extends Node

var save : save_data

#func _enter_tree():
	#load_data()

func load_data(pers : person):
	if ResourceLoader.exists("user://save.res"):
		var saved = ResourceLoader.load("user://save.res")
		if saved is save_data:
			save = saved
			pers.stats = save

func save_data():
	var result = ResourceSaver.save(save, "user://save.res")
	assert(result == OK)
