extends "res://scripts/guy.gd"

var distance = 1

func _ready():
	pass

func death():
	scene_handler.next_scene()

func knockback(power):
	distance += power
