extends person
class_name player

func _physics_process(_delta: float) -> void:
	var input_vector := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	sword.look_at(get_global_mouse_position())

	var move_direction := input_vector.normalized()
	move_and_slide(speed * move_direction)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		sword.attack()
