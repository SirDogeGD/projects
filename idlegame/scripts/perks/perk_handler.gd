extends Node

var rng = RandomNumberGenerator.new()
var combo = 0

#weapon dmg perks/a = attacker/b = attacked person/d = dmg
#weapon base dmg perks
func offensive_one(a, b, d):
	var perks_a = a.get_perks()
	var perks_b = b.get_perks()
	if 0 in perks_a:
		d += 1
	if 8 in perks_a:
		d += 1
	return d
#weapon multi perks
func offensive_two(a, b, d):
	rng.randomize()
	var perks_a = a.get_perks()
	var perks_b = b.get_perks()
	if 1 in perks_a:
		d = d*1.04
	if 2 in perks_a:
		if(b.current_hp <= b.hp/2):
			d = d*1.06
	if 3 in perks_a:
		if(b.current_hp >= b.hp/2):
			d = d*1.07
	if 4 in perks_a:
		for n in range(a.hp - a.current_hp):
			d = d*1.01
	if 5 in perks_a:
		if(a.current_shield > 0):
			d = d*1.05
	if 9 in perks_a:
		if rng.randi_range(1, 100) <= 12:
			d = d*1.5
	if 11 in perks_a:
		if combo%4 == 0:
			d = d*1.2
	if 16 in perks_a:
		if a.first_strike:
			d = d*1.35
			a.first_strike = false
	return d
#weapon true perks
func offensive_three(a, b, d):
	var perks_a = a.get_perks()
	var perks_b = b.get_perks()
	if 12 in perks_a:
		if combo%4 == 0:
			a.heal(0, 0.8)
	print(perks_a)
	if 14 in perks_a:
		if combo%4 == 0:
			var e = effect_handler.new_effect("weakness", 1, 1)
			effect_handler.add_effect(e, b)
	if 15 in perks_a:
		a.heal(d * 0.04, 0)
	return d
#armor base perks
func defensive_one(a, b, armor):
	var perks_a = a.get_perks()
	var perks_b = b.get_perks()
	if 6 in perks_b:
		armor += 5
	if 7 in perks_b:
		armor += 6
	return armor
#armor multi perks
func defensive_two(a, b, armor):
	var perks_a = a.get_perks()
	var perks_b = b.get_perks()
	return armor
#armor true perks
func defensive_three(a, b, d):
	var perks_a = a.get_perks()
	var perks_b = b.get_perks()
	return d
