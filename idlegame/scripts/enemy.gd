extends "res://scripts/guy.gd"

var distance = 1

func _ready():
	pass

func death():
	you.kill()

func knockback(power):
	distance += power
