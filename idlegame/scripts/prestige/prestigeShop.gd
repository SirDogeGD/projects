extends Node2D

func _ready():
	update_labels()
	stock()

func _on_BBack_pressed():
	get_tree().change_scene("res://scripts/prestige/prestige.tscn")

func update_labels():
	$VBoxContainer/HBoxContainer/LRenown.set_text(str("Renown: ", stats.renown))

func stock():
	for n in prestige_handler.make_shop_items():
		$VBoxContainer/GridContainer.add_child(n)
