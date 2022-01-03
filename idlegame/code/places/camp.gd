extends Node2D

func _ready():
	you.create_empty_inv()
	you.add_to_inv(item_creator.default_sword())
	update()
	chat.clear()
	$C1/TB/XPStatShower.type("xp")
	$C1/TB/GStatShower.type("g")

func update():
	$C1/VC/CCInv/Control.fill()

func _on_ButtonJD_pressed():
	scene_handler.next_scene()

func _on_ButtonSh_pressed():
	get_tree().change_scene("res://code/shop/shop.tscn")

func _on_ButtonP_pressed():
	get_tree().change_scene("res://code/prestige/prestige.tscn")
