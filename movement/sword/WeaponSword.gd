extends Node2D

const DRAG_FACTOR := 15.0
const RUN_SPEED := 600.0

var _velocity := Vector2.ZERO

onready var animation_player := $AnimationPlayer

func attack() -> void:
	animation_player.play("slash")
	yield(animation_player, "animation_finished")
	animation_player.play("RESET")

func test():
	pass
