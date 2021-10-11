extends Node

#weapon dmg perks/a = attacker/b = attacked person/d = dmg
#weapon base dmg perks
func offensive_one(a, b, d):
	var perks_a = a.get_perks()
	var perks_b = b.get_perks()
	if perks_a.has(0):
		d += 1
	if perks_a.has(8):
		d += 1
	return d
#weapon multi perks
func offensive_two(a, b, d):
	var perks_a = a.get_perks()
	var perks_b = b.get_perks()
	if perks_a.has(1):
		d = d*1.04
	if perks_a.has(2):
		if(b.current_hp <= b.hp/2):
			d = d*1.06
	if perks_a.has(3):
		if(b.current_hp >= b.hp/2):
			d = d*1.07
	if perks_a.has(4):
		for n in range(a.hp - a.current_hp):
			d = d*1.01
	if perks_a.has(5):
		if(a.current_shield > 0):
			d = d*1.05
	return d
#weapon true perks
func offensive_three(a, b, d):
	var perks_a = a.get_perks()
	var perks_b = b.get_perks()
	return d
#armor base perks
func defensive_one(a, b, armor):
	var perks_a = a.get_perks()
	var perks_b = b.get_perks()
	if perks_b.has(6):
		armor += 5
	if perks_b.has(7):
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
