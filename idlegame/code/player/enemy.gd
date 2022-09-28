extends "res://code/player/guy.gd"
class_name enemy_file

func _ready():
	is_player = false
	strong()

func death():
	scene_handler.next_scene()

func strong():
	perks.append("DIA_SWORD")
	perks.append("DIA_BOOT")
	perks.append("DIA_CHEST")
	if 8 in stats.pUpgrades:
		bounty = scene_handler.rng.randi_range(1, abs(scene_handler.rng.randfn()*50)) * 100
