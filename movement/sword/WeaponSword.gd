extends Node2D

const DRAG_FACTOR := 15.0
const RUN_SPEED := 600.0

var _velocity := Vector2.ZERO

onready var animation_player := $AnimationPlayer

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		animation_player.play("slash")
		yield(animation_player, "animation_finished")
		animation_player.play("RESET")
