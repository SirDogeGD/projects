extends Node

var count = 0
var perks = 0
var max_perks = 1
var rng = RandomNumberGenerator.new()

func next_scene():
	effect_handler.turn(you)
	if(is_perk()):
		perks += 1
		get_tree().change_scene("res://scenes/perk_choose.tscn")
	elif(is_shop()):
		count += 1
		get_tree().change_scene("res://scenes/runshop.tscn")
	elif(is_minor()):
		count += 1
		what_minor()
	else:
		count += 1
		get_tree().change_scene("res://scenes/fight.tscn")

func is_perk():
	if(perks < max_perks):
		return true
	return false

func is_shop():
	if(count == 2):
		return true
	return false

func reset():
	count = 0
	perks = 0

func is_minor():
	rng.randomize()
	var chance = rng.randi_range(1,10)
	if(chance <= 5):
		return true
	return false

func what_minor():
	rng.randomize()
	var which = rng.randi_range(1,2)
	match which:
		1:
			get_tree().change_scene("res://scenes/events/quickmath.tscn")
#			get_tree().change_scene("res://scripts/events/contract/contract.tscn")
		2:
			get_tree().change_scene("res://scripts/events/contract/contract.tscn")
