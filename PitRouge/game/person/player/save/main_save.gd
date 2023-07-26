extends Node

var save : save_data
var pers : player

func _enter_tree():
	pers = preload("res://game/person/player/playerchar.tscn").instantiate()
	load_data()

func load_data():
	if ResourceLoader.exists("user://save.res"):
		var saved = ResourceLoader.load("user://save.res")
		if saved is save_data:
			save = saved
			pers.stats = save

func save_data():
	var result = ResourceSaver.save(save, "user://save.res")
	assert(result == OK)
