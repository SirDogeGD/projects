extends Node

var num : float
var lvl : int
var a : person
var b : person

#Get values of single stuff (like Sweaty)
func get_value(a : person, id : String, num := 0) -> float:
	lvl = a.perks.count(id)
	if lvl >= 1:
		return get_num(id, num)
	return 0

#which = base, mult, true, etc
#a = attacker
#b = defender
func calc(which : String, attacker : person, defender : person) -> float:
	
	a = attacker
	b = defender
	
	#reset num
	num = 0
	if which.left(4) == "mult":
		num = 1.0
	
	#calc for each unique perk
	for p in a.perks.get_uniques():
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
func get_num(id : String, num := 0) -> float:
	lvl = a.perks.count(id)
	return float(PINFO.perkinfo(id, a).nums[lvl][num])

func calc_base_dmg(id : String):
	var add := get_num(id)
	match id:
		"BARB", "DIA_SWORD":
			num += add

func calc_mult_dmg(id : String):
	var add := get_num(id) / 100
	match id:
		"SHARP":
			num += add
		"PUN":
			if b.health.curHP <= b.health.maxHP/2:
				num += add
		"K_BUST":
			if b.health.curHP >= b.health.maxHP/2:
				num += add
		"PF":
			for n in range(a.health.maxHP - a.health.curHP):
				num += add
		"GAB":
			for n in range(a.health.curSH):
				num += add
		"C_DMG":
			if a.effect_node.get_boost("C_DMG") >= 4:
				a.effect_node.clear_effect("C_DMG")
				num += add
		"FSTRIKE":
			if b.health.curHP >= b.health.maxHP * 0.95:
				num += add
		"BHUNT":
			var buff = b.run_stats.bounty / 100 * add
			if "HTH" in b.perks:
				buff *= PINFO.perkinfo("HTH", a).nums[b.perks.count("HTH")][0]
			num += buff

func calc_base_def(id : String):
	var add := 1 - get_num(id) / 100 #eg 1 - 0.2 = 0.8 = 20% dmg reduction
	var def := 0.0
	match id:
		"DIA_BOOT", "DIA_CHEST", "PROT":
			def = add
		"DAG":
			if b.run_stats.bounty > 0:
				def = add
		"BILLY":
			def = a.run_stats.bounty / 1000 * add
		"DA":
			for p in b.perks.get_uniques():
				if p.begins_with("DIA"):
					def = add
					break
		"NGLAD":
			if a.radii.has_node("perk_NGLAD"):
				for p in a.radii.perk_GLAD.gpir(id):
					def += add
	num *= def

func calc_cc(id : String):
	var add := get_num(id)
	match id:
		"BERS":
			num += add

func calc_cd(id : String):
	var add := get_num(id)
	num = add

func calc_base_gold(id : String):
	var add := get_num(id)
	match id:
		"MOCT", "GBUMP":
			num += add

func calc_mult_gold(id : String):
	var add := 1 + get_num(id) / 100
	match id:
		"GBOOST":
			num *= add

func calc_base_xp(id : String):
	var add := get_num(id)
	match id:
		"XPBUMP":
			num += add

func calc_mult_xp(id : String):
	var add := 1 + get_num(id) / 100
	match id:
		"XPBOOST":
			num *= add

func can_block(a : person) -> bool:
	var no_block_perks := ["BARB"]
	for no_block_perk in no_block_perks:
		if a.perks.count(no_block_perk) > 0:
			return false
	return true

#handle perks that activate on hit
func on_hit(a : person, b : person, d : dmg_data):
	var ls_val := get_value(a, "LS")
	if ls_val != 0:
		a.health.curHP += d.amount * ls_val / 100
#	add COMBO
	for c_perk in PINFO.get_combo_perks():
		var c_val := get_value(a, c_perk)
		if c_val != 0:
			a.effect_node.add_effect(c_perk, 5)
	
	if a.effect_node.get_boost("C_SHIELD") >= 4:
		a.effect_node.clear_effect("C_SHIELD")
		a.health.curSH += get_value(a, "C_SHIELD")
	
	if a.effect_node.get_boost("C_CRUSH") >= 4:
		a.effect_node.clear_effect("C_CRUSH")
		var nums = [get_value(a, "C_CRUSH"), get_value(a, "C_CRUSH", 1)]
		for i in range(nums[0]):
			b.effect_node.add_effect("WEAK", nums[1], a.name)

#handle perks that activate on kill
func on_kill(a : person, b : person):
	var guts_val := get_value(a, "GUTS")
	if guts_val != 0:
		a.health.curHP += guts_val
	
	var jan_val := get_value(a, "C_JAN")
	if jan_val != 0:
		a.effect_node.add_effect("RES", get_value(a, "C_JAN", 1))
	
	var sco_val := get_value(a, "SCO")
	if sco_val != 0:
		bountyHandler.checkout(a, sco_val)

func on_ingot_pickup(a : person):
	var pebble_hp := get_value(a, "PEBBLE", 1)
	if pebble_hp != 0:
		a.health.curSH += pebble_hp

func get_bonus_maxsh(a : person) -> int:
	var bonus := 0
	for p in a.perks.get_uniques():
		if p in ["C_SHIELD", "PEBBLE"]:
			bonus += 2
	return bonus

func on_timer_timeout(a : person, id : String):
	var val := 0.0
	var lvl := a.perks.count(id)
	
	match id:
		"BOO":
			val = get_value(a, id, lvl)
			a.health.curHP += val
