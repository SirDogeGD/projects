extends Node2D

onready var animation_player := $AnimationPlayer

func take_damage(amount: int):
	animation_player.play("hit")
	print("Damage: ", amount)
