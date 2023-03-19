extends person
class_name player

func _physics_process(delta):
	
	handle_inputs()
	
	super._physics_process(delta)
	
	item.look_at(get_global_mouse_position())

func handle_inputs():
	
	var input_direction := Vector2(Input.get_action_strength("right") - Input.get_action_strength("left")
	, Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	velocity = input_direction * SPEED
	
	if Input.is_action_just_pressed("space"):
		dash(input_direction)
	
	if Input.is_action_just_pressed("sneak"):
		is_sneaking = true
	
	if Input.is_action_just_released("sneak"):
		is_sneaking = false
	
	if Input.is_action_just_pressed("left_click"):
		left_click()
	
	if Input.is_action_just_pressed("right_click"):
		right_click(true)
	
	if Input.is_action_just_released("right_click"):
		right_click(false)
