extends Node2D

func _ready():
	stock()

func _on_BBack_pressed():
	scene_handler.scene("res://code/prestige/prestige.tscn")

func stock():
	for n in prestige_handler.make_shop_items():
		$VBoxContainer/CenterContainer/GridContainer.add_child(n)
