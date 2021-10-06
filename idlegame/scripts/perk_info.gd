extends Node

var perkfile = load("res://scripts/perk.gd")
var choice = [1, 2, 3]

func perkinfo(id):
	match id:
		0:
			return make("Barbarian", "Your weapon has +1 dmg")
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
			return make("Prot boots", "Gain +5 armor")
		7:
			return make("Prot Chestplate", "Gain +6 armor")
		8:
			return make("Diamond Weapon" , "Your weapon deals +1 dmg")

func make(n, d):
	var perkinfo = perkfile.new()
	perkinfo.set_name(n)
	perkinfo.set_desc(d)
	return perkinfo

func make_choice():
	var array_pool = []
	var default_perks = [1, 2, 3, 4, 5]
#	add perks to pool
	array_pool += default_perks
#	remove perks player already has
	for x in you.perks:
		if array_pool.has(x):
			array_pool.erase(x)
#	get random perks from pool
	randomize()
	array_pool.shuffle()
	choice.clear()
	choice.append(array_pool[0])
	choice.append(array_pool[1])
	choice.append(array_pool[2])
	return choice
