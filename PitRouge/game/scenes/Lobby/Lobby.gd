extends Node2D

@onready var p : player = SAVE.pers

func _ready():
	add_child(p)
