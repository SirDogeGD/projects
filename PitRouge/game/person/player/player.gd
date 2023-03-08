extends person
class_name player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	var input_direction := Vector2(Input.get_action_strength("right") - Input.get_action_strength("left")
	, Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	velocity = input_direction * SPEED
	
	move_and_slide()
