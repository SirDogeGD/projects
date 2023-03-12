extends person
class_name player

func _physics_process(delta):
	
	var input_direction := Vector2(Input.get_action_strength("right") - Input.get_action_strength("left")
	, Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	velocity = input_direction * SPEED
	
	if Input.is_action_just_pressed("space"):
		dash(input_direction)
	
	move_and_slide()
