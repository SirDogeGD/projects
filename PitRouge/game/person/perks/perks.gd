extends Node

var num : float
var lvl : int

#which = base, mult, true, etc
#a = attacker
#b = defender
func calc(which : String, a : person, b : person) -> float:
	
	var u_perks := []
	
	#get unique perks
	for p in a.perks:
		if not u_perks.has(p):
			u_perks.append(p)
	
	#reset num
	num = 0
	
	#calc for each unique perk
	for p in u_perks:
		lvl = a.perks.count(p)
		match which:
			"base_dmg":
				calc_base_dmg(p)
			"mult_dmg":
				calc_mult_dmg(p)
			"base_def":
				calc_base_def(p)
	return num

func calc_base_dmg(id : String):
	match id:
		"BARB":
			num += 0.8 + (lvl * 0.2)
		"DIA_SWORD":
			num += 0.8 + (lvl * 0.2)

func calc_mult_dmg(id : String):
	match id:
		"SHARP":
			num += 0.04 + (lvl * 0.02)

func calc_base_def(id : String):
	var d := 0.0
	match id:
		"DIA_BOOT":
			d = 0.1 + (lvl * 0.05)
	num = d * (100 - num * 100) / 100
