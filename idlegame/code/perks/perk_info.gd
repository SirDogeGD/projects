extends Node

var perkfile = load("res://code/perks/perk.gd")
var choice = [1, 2, 3]

func perkinfo(id):
	match id:
		0, "BARB":
			return make("Barbarian", "Your weapon deals +1 dmg",
				[[1][1.1][1.2][1.3]],"DEFAULT")
		1, "SHARP":
			return make("Sharp", "Deal +4% melee damage",
				[[4][8][12][16]],"DEFAULT")
		2, "PUN":
			return make("Punisher", "Deal +6% damage vs. players below 50% HP",
				[[6][12][18][24]],"DEFAULT")
		3, "K_BUST":
			return make("King Buster", "Deal +7% damage vs. players above 50% HP",
				[[7][13][19][25]],"DEFAULT")
		4, "PF":
			return make("Pain Focus", "Deal +1% damage per hp❤ you're missing",
				[[2][3][4][5]],"DEFAULT")
		5, "G_A_B":
			return make("Gold and Boosted", "Deal +5% damage when you have shield hp",
				[[5][10][15][20]],"DEFAULT")
		6, "DIA_BOOT":
			return make("Diamond boots", "Gain +5 armor",
				[[5][6][7][8]],"DEFAULT")
		7, "DIA_CHEST":
			return make("Diamond Chestplate", "Gain +6 armor",
				[[6][7][8][9]],"DEFAULT")
		8, "DIA_SWORD":
			return make("Diamond Sword", "Your weapon deals +1 dmg",
				[[1][1.1][1.2][1.3]],"DEFAULT")
#			mysticism 1
		9, "BERS":
			return make("Berserker", "12% chance to crit for 50% extra damage",
				[[12][20][28][36]],"DEFAULT")
		10, "GUTS":
			return make("Guts", "Heal 0.25hp on kill",
				[[0.25][0.4][0.55][0.7]],"DEFAULT")
		11, "C_DMG":
			return make("Combo: Damage", "Every fourth strike deals +20% damage",
				[[20][30][40][50]],"DEFAULT")
		12, "C_SHIELD":
			return make("Combo: Shield", "Every fourth strike gives 0.8 shield hp",
				[[0.8][1][1.2][1.4]],"DEFAULT")
#		mysticism 2
		13, "C_JAN":
			return make("Counter-Janitor", "Gain Resistance I (2 turns) on kill",
				[[2][3][4][5]],"DEFAULT")
		14, "C_CRUSH":
			return make("Combo: Crush", "Every fourth strike apply Weakness I for 1 turn",
				[[1][2][3][4]],"DEFAULT")
		15, "LS":
			return make("Lifesteal", "Heal for 4% of damage dealt",
				[[4][8][12][16]],"DEFAULT")
		16, "F_STRIKE":
			return make("First Strike", "First hit against an enemy deals +35% dmg",
				[[35][40][45][50]],"DEFAULT")

func make(n, d, num, u):
	var p = perkfile.new()
	p.set_name(n)
	p.set_desc(d)
	p.set_nums(num)
	p.set_unlock(u)
	return p

func make_choice():
	var array_pool = []
	var default_perks = ["SHARP", "PUN", "K_BUST", "PF", "G_A_B"]
	var myst1 = ["BERS", "GUTS", "C_DMG", "C_SHIELD"]
	var myst2 = ["C_JAN", "C_CRUSH", "LS", "F_STRIKE"]
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
	choice = perks.slice(0,2)
	return choice
