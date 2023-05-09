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
			"base":
				calc_base(p)
			"mult":
				calc_mult(p)
	return num

func calc_base(id : String):
	match id:
		"BARB":
			num += 0.8 + (lvl * 0.2)
		"DIA_SWORD":
			num += 0.8 + (lvl * 0.2)

func calc_mult(id : String):
	match id:
		"SHARP":
			num += 0.8 + (lvl * 0.2)
