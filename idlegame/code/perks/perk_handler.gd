extends Node

var rng = RandomNumberGenerator.new()
var combo = 0
var perks_a
var perks_b

#weapon dmg perks/a = attacker/b = attacked person/d = dmg
#weapon base dmg perks
func calc_base(a : guy, b : guy, d):
	get_perks(a, b)
	for p in perks_a:
		match p:
			"BARB":
				d += 1
			"DIA_SWORD":
				d += 1
	return d
#weapon multi perks
func calc_mult(a : guy, b : guy, d):
	rng.randomize()
	get_perks(a, b)
	for p in perks_a:
		match p:
			"SHARP":
				d += 4
			"PUN":
				if(b.current_hp <= b.hp/2):
					d += 6
			"K_BUST":
				if(b.current_hp >= b.hp/2):
					d += 7
			"PF":
				for n in range(a.hp - a.current_hp):
					d += 1
			"G_A_B":
				if(a.current_shield > 0):
					d += 5
			"C_DMG":
				if combo%4 == 0:
					d += 20
			"F_STRIKE":
				if a.first_strike:
					d += 35
					a.first_strike = false
			"B_HUNT":
				var buff = b.bounty / 100
				if "HTH" in b.perks:
					buff / 2
				d += buff
	return d
#weapon true perks, effects, healing
func calc_tru(a : guy, b : guy, d):
	get_perks(a, b)
	for p in perks_a:
		match p:
			"C_SHIELD":
				if combo%4 == 0:
					a.heal(0, 0.8)
			"C_CRUSH":
				if combo%4 == 0:
					var e = effect_handler.new_effect("weakness", 1, 1)
					effect_handler.add_effect(e, b)
			"LS":
				a.heal(d * 0.04, 0)
	return d

func calc_cc(a : guy, b : guy, d):
	get_perks(a, b)
	for p in perks_a:
		match p:
			"BERS":
				a.cc += 12

#armor base perks
func calc_armor(a : guy, b : guy, armor):
	get_perks(a, b)
	for p in perks_a:
		match p:
			"DIA_BOOT":
				armor += 5
			"DIA_CHEST":
				armor += 6
			"DAG":
				if b.bounty > 0:
					armor += 30
			"BILLY":
				armor += a.bounty / 1000
	return armor
#armor multi perks
func defensive_two(a : guy, b : guy, armor):
	get_perks(a, b)
	return armor
#armor true perks
func defensive_three(a : guy, b : guy, d):
	get_perks(a, b)
	return d

func on_kill():
	var perks = you.perks
	for p in perks:
		match p:
			"C_JAN":
				var e = effect_handler.new_effect("res", 1, 2)
				effect_handler.add_effect(e, you)
			"SCO":
				if you.bounty >= you.bounty_max:
					stats.add_stats("g", you.bounty)
					you.bounty = 0
					perks.erase(p)

func get_perks(a : guy, b : guy):
	perks_a = a.perks
	perks_b = b.perks
