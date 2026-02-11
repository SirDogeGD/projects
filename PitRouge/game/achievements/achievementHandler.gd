extends Node

signal achievement_unlocked(id)

var save_file_path := "user://achievements.save"

var achievements := {}  # id → Achievement object

func _ready():
	register_achievements()
	load_achievements()
	achievement_unlocked.connect(unlock_achievement)

func save_achievements():
	var data := {}
	
	for id in achievements:
		var a = achievements[id]
		data[id] = {
			"unlocked": a.unlocked,
			"progress": a.progress
		}
	
	var f = FileAccess.open(save_file_path, FileAccess.WRITE)
	f.store_var(data)
	f.close()

func load_achievements():
	if not FileAccess.file_exists(save_file_path):
		return

	var f = FileAccess.open(save_file_path, FileAccess.READ)
	var data = f.get_var()
	f.close()
	print(data)
	for id in data:
		if id in achievements:
			var a = achievements[id]
			a.unlocked = data[id]["unlocked"]
			a.progress = data[id]["progress"]

func register_achievements():
	var folder := "res://game/achievements/achievements/"
	var dir := DirAccess.open(folder)
	if not dir:
		push_error("Achievement folder missing!")
		return

	dir.list_dir_begin()

	var file_name = dir.get_next()
	while file_name != "":
		if file_name.ends_with(".tres"):
			var path = folder + file_name
			var achievement = load(path)
			achievements[achievement.id] = achievement
			achievement.register()
		file_name = dir.get_next()

	dir.list_dir_end()

func reset_achievements():
	for id in achievements:
		var a = achievements[id]
		a.unlocked = false
		a.progress = 0
		save_achievements()

func unlock_achievement(id : String):
	pass
