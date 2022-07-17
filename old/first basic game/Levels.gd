extends Node2D

var lvl = 1

func _ready():
	pass # Replace with function body.

func nextLvl():
	lvl = lvl + 1
	var lvlnum = str(lvl)
	get_tree().change_scene("res://levels/level" + lvlnum + ".tscn")
	print("next level: " + lvlnum)
