extends Node2D

func _ready():
	you.create_empty_inv()
	you.add_to_inv(item_creator.default_sword())
	update_stats()

func update_stats():
	$C1/TB/LXP.set_text("XP: " + String(stats.xp))
	$C1/TB/LG.set_text("Gold: " + String(stats.gold))
	$C1/VC/CCInv/Control.fill()

func _on_ButtonJD_pressed():
	get_tree().change_scene("res://scenes/fight.tscn")

func _on_ButtonSh_pressed():
	get_tree().change_scene("res://scenes/shop.tscn")
