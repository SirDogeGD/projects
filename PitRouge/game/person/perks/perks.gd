extends Node

var num : float
var lvl : int
var a : person
var b : person

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

# returns [num] of perk
# eg [1, 2, 3, 5] returns 2 if num = 1
func get_num(id : String, _num := 0) -> float:
	lvl = a.perks.count(id)
	if lvl > 0:
		return float(PINFO.perkinfo(id, a).nums[lvl-1][_num])
	return 0

func get_a_num(_a : person, id : String, _num := 0) -> float:
	a = _a
	return get_num(id, _num)

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
			if b.health.curHP <= b.health.maxHP/2.0:
				num += add
		"K_BUST":
			if b.health.curHP >= b.health.maxHP/2.0:
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
			var buff = b.run_stats.bounty / 100.0 * add
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
			def = a.run_stats.bounty / 1000.0 * add
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

func can_block(_a : person) -> bool:
	a = _a
	var no_block_perks := ["BARB"]
	for no_block_perk in no_block_perks:
		if _a.perks.count(no_block_perk) > 0:
			return false
	return true

#handle perks that activate on hit
func on_hit(_a : person, _b : person, d : dmg_data):
	a = _a
	var ls_val := get_num("LS")
	if ls_val != 0:
		_a.health.curHP += d.amount * ls_val / 100
#	add COMBO
	for c_perk in PINFO.get_combo_perks():
		var c_val := get_num(c_perk)
		if c_val != 0:
			_a.effect_node.add_effect(c_perk, 5)
	
	if _a.effect_node.get_boost("C_SHIELD") >= 4:
		_a.effect_node.clear_effect("C_SHIELD")
		_a.health.curSH += get_num("C_SHIELD")
	
	if _a.effect_node.get_boost("C_CRUSH") >= 4:
		_a.effect_node.clear_effect("C_CRUSH")
		var nums = [get_num("C_CRUSH"), get_num("C_CRUSH", 1)]
		for i in range(nums[0]):
			_b.effect_node.add_effect("WEAK", nums[1], _a.name)

#handle perks that activate on kill
func on_kill(_a : person, _b : person):
	a = _a
	var guts_val := get_num("GUTS")
	if guts_val != 0:
		a.health.curHP += guts_val
	
	var jan_val := get_num("C_JAN")
	if jan_val != 0:
		var nums = [get_num("C_JAN"), get_num("C_JAN", 1)]
		print(nums)
		for i in range(nums[0]):
			_a.effect_node.add_effect("RES", nums[1])
	
	var sco_val := get_num("SCO")
	if sco_val != 0:
		bountyHandler.checkout(_a, sco_val) 

func on_ingot_pickup(_a : person):
	a = _a
	var pebble_hp := get_num("PEBBLE", 1)
	if pebble_hp != 0:
		_a.health.curSH += pebble_hp

func get_bonus_maxsh(_a : person) -> int:
	a = _a
	var bonus := 0
	for p in _a.perks.get_uniques():
		if p in ["C_SHIELD", "PEBBLE"]:
			bonus += 2
	return bonus

func on_timer_timeout(_a : person, id : String):
	a = _a
	var val := 0.0
	lvl = _a.perks.count(id)
	
	match id:
		"BOO":
			val = get_num(id, lvl)
			_a.health.curHP += val
