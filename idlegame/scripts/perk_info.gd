extends Node

var perkfile = load("res://scripts/perk.gd")

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

func make(n, d):
	var perkinfo = perkfile.new()
	perkinfo.set_name(n)
	perkinfo.set_desc(d)
	return perkinfo
