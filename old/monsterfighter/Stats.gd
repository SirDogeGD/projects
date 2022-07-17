extends Node

var lvl = 1
var strength = 1
var def = 1
var hp = 1

var dict = {}

func save():
	var save_dict = {
		"Level" : lvl,
		"Strength" : strength,
		"Defence" : def,
		"Hp" : hp
		}
	return save_dict

func save_Stats():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line(to_json(save()))
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://savegame.save", File.READ)
	var json = JSON.parse(save_game.get_as_text())
	dict = json.result
	save_game.close()
	
	lvl = dict["Level"]
	strength = dict["Strength"]
	def = dict["Defence"]
	hp = dict["Hp"]

func reset():
	lvl = 1
	strength = 1
	def = 1
	hp = 1
	save_Stats()
