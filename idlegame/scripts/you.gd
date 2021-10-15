extends "res://scripts/guy.gd"

var selected = 0
var max_perks = 1

func _ready():
	create_empty_inv()

func death():
	you.streak = 0
	get_tree().change_scene("res://scenes/camp.tscn")
	current_hp = hp
	remove_on_death()
	perks.clear()
	scene_handler.reset()
	clear_effects()

func kill():
	you.streak += 1
	update_megas()
	var xp = calc_xp()
	var gold = calc_gold()
	stats.add_stats("xp", xp)
	stats.add_stats("g", gold)
	stats.add_stats("k", 1)
	get_on_kill_heal()
	return[xp, gold]

func set_selected(s):
	selected = s

func get_selected():
	return selected

func remove_on_death():
	for n in range(invsize):
		if(!inv[n].get_on_death()):
			inv[n] = item_creator.empty_slot()

func get_on_kill_heal():
	add_to_inv(heal_perks.get_healing(heal_perk))

func calc_xp():
	var base = 10
#	elgato
	if(streak < 6):
		base += int(upgrades["elgato"])
#	streak multi
	if(streak > 2):
		base += round(streak/3)
#	xpboost
	var xpboost = 1 + float(upgrades["xpboost"])/10
	base = base * xpboost
#	megastreak xp boost
	base = base * (mxpb + 1) 
	return base

func calc_gold():
	var base = 10
#	elgato
	if(streak > 6):
		base += int(upgrades["elgato"])
#	gold boost
	var gboost = 1 + float(upgrades["gboost"])/10
	base = base * gboost
#	megastreak gold boost
	base = base * (mgb + 1)
	return base
