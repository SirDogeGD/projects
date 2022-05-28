extends "res://code/player/guy.gd"

func _ready():
	is_player = false

func death():
	scene_handler.next_scene()
