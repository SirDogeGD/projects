extends Node

var perkfile = load("res://scripts/perks/perk.gd")
var choice = [1, 2, 3]

func perkinfo(id):
	match id:
		0:
			return make("Barbarian", "Your weapon deals +1 dmg")
		1:
			return make("Sharp", "Deal +4% melee damage")
		2:
			return make("Punisher", "Deal +6% damage vs. players below 50% HP")
		3:
			return make("King Buster", "Deal +7% damage vs. players above 50% HP")
		4:
			return make("Pain Focus", "Deal +1% damage per hp❤ you're missing")
		5:
			return make("Gold and Boosted", "Deal +5% damage when you have shield hp")
		6:
			return make("Diamond boots", "Gain +5 armor")
		7:
			return make("Diamond Chestplate", "Gain +6 armor")
		8:
			return make("Diamond Sword", "Your weapon deals +1 dmg")
#			mysticism 1
		9:
			return make("Berserker", "12% chance to crit for 50% extra damage")
		10:
			return make("Guts", "Heal 0.25hp on kill")
		11:
			return make("Combo: Damage", "Every fourth strike deals +20% damage")
		12:
			return make("Combo: Shield", "Every fourth strike gives 0.8 shield hp")
#		mysticism 2
		13:
			return make("Counter-Janitor", "Gain Resistance I (2 turns) on kill")
		14:
			return make("Crush", "Strikes apply Weakness I for a turn")
		15:
			return make("Lifesteal", "Heal for 4% of damage dealt")
		16:
			return make("First Strike", "First hit against an enemy deals +35% dmg")

func make(n, d):
	var perkinfo = perkfile.new()
	perkinfo.set_name(n)
	perkinfo.set_desc(d)
	return perkinfo

func make_choice():
	var array_pool = []
	var default_perks = [1, 2, 3, 4, 5]
	var myst1 = [9, 10, 11, 12]
	var myst2 = [13, 14, 15, 16]
#	add perks to pool
	array_pool += default_perks
	if 1 in stats.pUpgrades:
		array_pool += myst1
	if 6 in stats.pUpgrades:
		array_pool += myst2
#	get perks player doesnt already have
	var perks = []
	for x in array_pool.size():
		if not array_pool[x] in you.get_perks():
			perks.append(array_pool[x])
#	get random perks from pool
	randomize()
	perks.shuffle()
	choice.clear()
	choice.append(perks[0])
	choice.append(perks[1])
	choice.append(perks[2])
	return choice
