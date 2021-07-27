extends Node

func get_healing(x):
	match x:
		"gap":
			return gapple()
		"ghead":
			print("Two are better than one!")

func make_healing(n, ss, h, sh, d):
	var healFile = load("res://scripts/heal.gd")
	var heal = healFile.new()
	heal.set_name(n)
	heal.set_ssize(ss)
	heal.set_hp(h)
	heal.set_shield(sh)
	heal.set_on_death(d)
	return heal

func gapple():
	 return make_healing("Golden Apple", 2, 5, 5, false)

func ghead():
	var ghead = make_healing("Golden Apple", 2, 5, 5, false)
	ghead.is_insta()
	return ghead
