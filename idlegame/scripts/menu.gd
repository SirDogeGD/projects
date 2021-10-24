extends Node2D

func _ready():
#	stats.save_Stats()
	stats.load_Stats()

#go into main game "Lobby"
func _on_BS_pressed():
	get_tree().change_scene("res://scenes/camp.tscn")

#show credits
func _on_BC_pressed():
	pass
