extends Node2D

func _ready():
#	stats.save_Stats()
	stats.load_Stats()

#go into main game "Lobby"
func _on_BS_pressed():
	scene_handler.scene("res://code/places/camp.tscn")

#show credits
func _on_BC_pressed():
	pass
