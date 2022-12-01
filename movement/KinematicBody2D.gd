extends KinematicBody2D
class_name player

var stats: PlayerSave setget set_stats

export var speed := 400.0

func _physics_process(_delta: float) -> void:
	var input_vector := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

	var move_direction := input_vector.normalized()
	move_and_slide(speed * move_direction)

func set_stats(new_stats: PlayerSave) -> void:
	stats = new_stats
	set_physics_process(stats != null)
