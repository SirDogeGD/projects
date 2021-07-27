extends Node2D

func _ready():
	stats.load_Stats()

func _on_BS_pressed():
	get_tree().change_scene("res://scenes/camp.tscn")
