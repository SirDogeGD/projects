extends Sprite2D

var sel_img = load("res://img/inventory/selected.png")
var not_sel_img = load("res://img/inventory/not selected.png")

func update_img(selected : bool):
	texture = not_sel_img if not selected else sel_img
