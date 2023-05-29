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
			"cc":
				calc_cc(p)
			"cd":
				calc_cd(p)
			"base_gold":
				calc_base_gold(p)
			"mult_gold":
				calc_mult_gold(p)
			"base_xp":
				calc_base_xp(p)
			"mult_xp":
				calc_mult_xp(p)
	return num

#get the first number of the current level (most perks just have one number)
func get_num1(id : String) -> float:
	return PINFO.get_key(id, "Nums")[lvl][0]

func get_num(id : String) -> float:
	return PINFO.get_key(id, "Nums")[lvl][1]

func calc_base_dmg(id : String):
	var add := get_num1(id)
	match id:
		"BARB", "DIA_SWORD":
			num += add

func calc_mult_dmg(id : String):
	var add := get_num1(id) / 100
	match id:
		"SHARP":
			num += add
		"PUN":
			if b.health <= b.health_max/2:
				num += add
		"K_BUST":
			if b.health >= b.health_max/2:
				num += add
		"PF":
			for n in range(a.health_max - a.health):
				num += add
		"GAB":
			if a.shield > 0:
				num += add
		#"C_DMG":
		"FSTRIKE":
			if b.health >= b.health_max * 0.95:
				num += add
		"BHUNT":
			var buff = b.bounty / 100 * add
			if "HTH" in b.perks:
				buff *= PINFO.get_key("HTH", "Nums")[b.perks.count("HTH")][0]
			num += buff

func calc_base_def(id : String):
	var add := 1 - get_num1(id) / 100 #eg 1 - 0.2 = 0.8 = 20% dmg reduction
	var def := 0.0
	match id:
		"DIA_BOOT", "DIA_CHEST":
			def = add
		"DAG":
			if b.bounty > 0:
				def = add
		"BILLY":
			def = a.bounty / 1000 * add
	num *= def

func calc_cc(id : String):
	var add := get_num1(id)
	num = add

func calc_cd(id : String):
	var add := get_num1(id)
	num = add

func calc_base_gold(id : String):
	var add := get_num1(id)
	match id:
		"MOCT", "GBUMP":
			num += add
	num = add

func calc_mult_gold(id : String):
	var add := 1 + get_num1(id) / 100
	match id:
		"GBOOST":
			num *= add
	num = add

func calc_base_xp(id : String):
	var add := get_num1(id)
	match id:
		"XPBUMP":
			num += add
	num = add

func calc_mult_xp(id : String):
	var add := 1 + get_num1(id) / 100
	match id:
		"XPBOOST":
			num *= add
	num = add
