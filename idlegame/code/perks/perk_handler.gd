extends Node

var rng = RandomNumberGenerator.new()
var combo = 0
var perks_a
var perks_b

#weapon dmg perks/a = attacker/b = attacked person/d = dmg
#weapon base dmg perks
func offensive_one(a, b, d):
	get_perks(a, b)
	for p in perks_a:
		match p:
			"BARB":
				d += 1
			"DIA_SWORD":
				d += 1
	return d
#weapon multi perks
func offensive_two(a, b, d):
	rng.randomize()
	get_perks(a, b)
	for p in perks_a:
		match p:
			"SHARP":
				d = d*1.04
			"PUN":
				if(b.current_hp <= b.hp/2):
					d = d*1.06
			"K_BUST":
				if(b.current_hp >= b.hp/2):
					d = d*1.07
			"PF":
				for n in range(a.hp - a.current_hp):
					d = d*1.01
			"G_A_B":
				if(a.current_shield > 0):
					d = d*1.05
			"BERS":
				if rng.randi_range(1, 100) <= 12:
					d = d*1.5
			"C_DMG":
				if combo%4 == 0:
					d = d*1.2
			"F_STRIKE":
				if a.first_strike:
					d = d*1.35
					a.first_strike = false
	return d
#weapon true perks
func offensive_three(a, b, d):
	get_perks(a, b)
	if 12 in perks_a:
		if combo%4 == 0:
			a.heal(0, 0.8)
	if 14 in perks_a:
		if combo%4 == 0:
			var e = effect_handler.new_effect("weakness", 1, 1)
			effect_handler.add_effect(e, b)
	if 15 in perks_a:
		a.heal(d * 0.04, 0)
	return d
#armor base perks
func defensive_one(a, b, armor):
	get_perks(a, b)
	if 6 in perks_b:
		armor += 5
	if 7 in perks_b:
		armor += 6
	return armor
#armor multi perks
func defensive_two(a, b, armor):
	get_perks(a, b)
	return armor
#armor true perks
func defensive_three(a, b, d):
	get_perks(a, b)
	return d

func on_kill():
	var perks = you.get_perks()
	if "C_JAN" in perks:
		var e = effect_handler.new_effect("res", 1, 2)
		effect_handler.add_effect(e, you)

func get_perks(a, b):
	perks_a = a.get_perks()
	perks_b = b.get_perks()