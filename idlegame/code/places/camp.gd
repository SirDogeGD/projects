extends Node2D

func _ready():
	you.create_empty_inv()
	you.add_to_inv(item_creator.default_sword())
	update()
	chat.clear()

func update():
	$C1/VC/CCInv/Control.fill()

func _on_ButtonJD_pressed():
	scene_handler.next_scene()

func _on_ButtonSh_pressed():
	scene_handler.scene("res://code/shop/shop.tscn")

func _on_ButtonP_pressed():
	scene_handler.scene("res://code/prestige/prestige.tscn")
