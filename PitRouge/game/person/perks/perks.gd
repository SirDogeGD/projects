extends Node

var num : float
var lvl : int
var a : person
var b : person

#which = base, mult, true, etc
#a = attacker
#b = defender
func calc(which : String, attacker : person, defender : person) -> float:
	
	var u_perks := []
	
	a = attacker
	b = defender
	
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
			num += get_num1(id)
		"PUN":
			if b.health <= b.health_max/2:
				num += get_num1(id)
		"K_BUST":
			if b.health >= b.health_max/2:
				num += get_num1(id)

func calc_base_def(id : String):
	var def := 0.0
	match id:
		"DIA_BOOT":
			def = get_num1(id)
	num = def * (100 - num * 100) / 100

func get_num1(id : String):
	return PINFO.get_key(id, "Nums")[lvl][0]
