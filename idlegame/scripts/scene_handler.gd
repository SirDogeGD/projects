extends Node

var count = 0
var perks = 0

func next_scene():
	count += 1
	if(is_perk()):
		perks += 1
		get_tree().change_scene("res://scenes/perk_choose.tscn")
	else:
		get_tree().change_scene("res://scenes/fight.tscn")

func is_perk():
	if(perks < you.max_perks):
		return true
	return false

func reset():
	count = 0
	perks = 0
