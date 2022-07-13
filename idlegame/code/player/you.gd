extends "res://code/player/guy.gd"

#for inventory
var selected = 0

func _ready():
	create_empty_inv()

func death():
	megastreak_handler.on_death(self, streak)
	streak = 0
	current_hp = hp
	remove_on_death()
	perks.clear()
	clear_effects()

func kill():
	you.streak += 1
	update_megas()
	
#	gold and xp
	var xp = calc_xp(10)
	var gold = calc_gold(10)
	scene_handler.run_g += gold
	scene_handler.run_xp += xp
	stats.add_stats("xp", xp)
	stats.add_stats("g", gold)
	stats.add_stats("k", 1)
	
	get_on_kill_heal()
	contract_handler.perk_and_kills(self.perks)
	perk_handler.on_kill()
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
	if 0 in stats.pUpgrades: #tenacity
		heal(1, 0)
	if 10 in perks: #guts
		heal(0.25, 0)
	if 13 in perks: #cjan
		var e = effect_handler.new_effect("res", 1, 2)
		effect_handler.add_effect(e, self)
	var heal_perks = load("res://code/fight/heal_perks.gd").new()
	add_to_inv(heal_perks.get_healing(heal_perk))

func calc_xp(base):
#	elgato
	if(streak < 6):
		base += int(upgrades["elgato"])
#	streak multi
	if(streak > 2):
		base += round(streak/3)
#	renown xp bump
	var xp_bump_ids = [4]
	for id in xp_bump_ids:
		if id in stats.pUpgrades:
			base += 1
#	xpboost
	var xpboost = 1 + float(upgrades["xpboost"])/10
	base = base * xpboost
#	megastreak xp boost
	base = base * (mxpb + 1)
	base = round(base)
	return base

func calc_gold(base):
#	elgato
	if(streak < 6):
		base += int(upgrades["elgato"])
#	gold boost
	var gboost = 1 + float(upgrades["gboost"])/10
	base = base * gboost
#	megastreak gold boost
	base = base * (mgb + 1)
#	renown gold boost
	var gold_boost_ids = [5]
	for id in gold_boost_ids:
		if id in stats.pUpgrades:
			base = base * 1.025
	base = round(base)
	return base
