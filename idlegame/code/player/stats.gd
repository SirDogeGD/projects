extends Node

#resources
var xp = 0
var gold = 0
#stats
var kills = 0
var highest_streak = 0
#prestige
var prestige = 0
var renown = 0
var pUpgrades = []

var dict
var echest = {}

func save():
	var save_dict = {
		"XP" : xp,
		"Gold" : gold,
		"Kills" : kills,
		"Highest Streak" : highest_streak,
		"Upgrades" : you.get_upgrades(),
		"Prestige" : prestige,
		"Renown" : renown,
		"pUpgrades" : pUpgrades
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
		save_Stats()
	save_game.open("user://savegame.save", File.READ)
	var json = JSON.parse(save_game.get_as_text())
	dict = json.result
	save_game.close()
	
#resources
	xp = int(dict["XP"])
	gold = int(dict["Gold"])
#stats
	kills = int(dict["Kills"])
	you.upgrades = dict["Upgrades"]
	shop_handler.purchases = dict["Upgrades"]["purchases"]
#prestige
	prestige = dict["Prestige"]
	renown = int(dict["Renown"])
	pUpgrades = dict["pUpgrades"]
	
	return dict

func add_stats(what, value):
#resources
	if(what == "xp"):
		xp += value
	if(what == "g"):
		gold += value
#stats
	if(what == "k"):
		kills += value
#prestige
	if what == "prestige":
		prestige += 1
	if what == "r":
		renown += value
	save_Stats()
