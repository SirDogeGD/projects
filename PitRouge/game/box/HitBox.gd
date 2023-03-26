@icon("HitBox.svg")
class_name HitBox
extends Area2D

@export var damage := 6.0

func _init():
	collision_mask = 0 
	collision_layer = 2
