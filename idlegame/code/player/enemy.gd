extends "res://code/player/guy.gd"
class_name enemy

func _ready():
	is_player = false

func death():
	scene_handler.next_scene()
