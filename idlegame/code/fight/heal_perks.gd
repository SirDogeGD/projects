extends Node

func get_healing(x):
	match x:
		"gap":
			return gapple()
		"ghead":
			print("Two are better than one!")

func make_healing(n, ss, h, sh, d, e):
	var healFile = load("res://code/items/heal.gd")
	var heal = healFile.new()
	heal.set_name(n)
	heal.set_ssize(ss)
	heal.set_hp(h)
	heal.set_shield(sh)
	heal.set_on_death(d)
	heal.add_effects(e)
	return heal

func gapple():
	var e = [effect_handler.new_effect("r", 1, 3)]
	return make_healing("Golden Apple", 2, 5, 10, false, e)

func ghead():
	var e = [effect_handler.new_effect("r", 1, 3)]
	var ghead = make_healing("Golden Head", 2, 5, 10, false, e)
	ghead.is_insta()
	return ghead
