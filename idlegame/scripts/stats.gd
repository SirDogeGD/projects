extends Node

var xp = 0
var gold = 0
var kills = 0
var highest_streak = 0

var dict = save()
var echest = {}

func save():
	var save_dict = {
		"XP" : xp,
		"Gold" : gold,
		"Kills" : kills,
		"Highest Streak" : highest_streak,
		"upgrades" : you.get_upgrades()
		}
	return save_dict

func save_Stats():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line(to_json(save()))
	save_game.close()

func load_Stats():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://savegame.save", File.READ)
	var json = JSON.parse(save_game.get_as_text())
	dict = json.result
	save_game.close()
	
	xp = int(dict["XP"])
	gold = int(dict["Gold"])
	kills = int(dict["Kills"])
	you.upgrades = dict["upgrades"]

func add_stats(what, value):
	if(what == "xp"):
		xp += value
	if(what == "g"):
		gold += value
	if(what == "k"):
		kills += value
	save_Stats()
