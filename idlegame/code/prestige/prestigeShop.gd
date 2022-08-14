extends Node2D

func _ready():
	stock()

func _on_BBack_pressed():
	scene_handler.scene("res://code/prestige/prestige.tscn")

func stock():
	print("restocking")
	var grid = $VBoxContainer/CenterContainer/GridContainer
	for c in grid.get_children():
		c.queue_free()
	for n in prestige_handler.make_shop_items():
		print(n)
		grid.add_child(n)
		n.connect("bought", self, "stock")
