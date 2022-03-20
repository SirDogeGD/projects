extends Node

func get_healing(x):
	match x:
		"gap":
			return gapple()
		"ghead":
			print("Two are better than one!")

func make_healing(n, ss, h, sh, d, e):
	var healFile = load("res://code/items/heal.gd").new()
	healFile.set_name(n)
	healFile.set_ssize(ss)
	healFile.set_hp(h)
	healFile.set_shield(sh)
	healFile.set_on_death(d)
	healFile.add_effects(e)
	return healFile

func gapple():
	var e = [effect_handler.new_effect("r", 1, 3)]
	return make_healing("Golden Apple", 2, 5, 10, false, e)

func ghead():
	var e = [effect_handler.new_effect("r", 1, 3)]
	var ghead = make_healing("Golden Head", 2, 5, 10, false, e)
	ghead.is_insta()
	return ghead
