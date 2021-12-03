extends Node

var count = 0
var perks = 0
var rng = RandomNumberGenerator.new()

func next_scene():
	effect_handler.turn(you)
	if(count == 0):
		count += 1
		get_tree().change_scene("res://scenes/perk_choose.tscn")
	elif(is_minor()):
		count += 1
		what_minor()
	else:
		count += 1
		get_tree().change_scene("res://scenes/fight.tscn")
		you.first_strike = true

func is_perk():
	var extra_perks = 0
	var extra_perks_id = [1, 6]
	for id in extra_perks_id:
		if id in stats.pUpgrades:
			extra_perks += 1
	if(perks < extra_perks):
		perks += 1
		return true
	else:
		return false

func reset():
	count = 0
	perks = 0

func is_minor():
	rng.randomize()
	var chance = rng.randi_range(1,70)
	if(chance <= 5):
		return true
	return false

func what_minor():
	rng.randomize()
	var which = rng.randi_range(0,3)
	match which:
		0:
			if is_perk():
				get_tree().change_scene("res://scenes/perk_choose.tscn")
			else:
				what_minor()
		1:
			get_tree().change_scene("res://scenes/shop/runshop.tscn")
		2:
			get_tree().change_scene("res://scenes/events/quickmath.tscn")
		3:
			get_tree().change_scene("res://scripts/events/contract/contract.tscn")
