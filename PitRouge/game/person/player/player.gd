extends person
class_name player

func _physics_process(delta):
	
	handle_inputs()
	
	super._physics_process(delta)
	
	item.look_at(get_global_mouse_position())
	
	pushback_force = lerp(pushback_force, Vector2.ZERO, delta * 10)
	set_velocity(pushback_force * 5)
	move_and_slide()

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
		click("left", true)
	
	if Input.is_action_just_released("left_click"):
		click("left", false)
	
	if Input.is_action_just_pressed("right_click"):
		click("right", true)
	
	if Input.is_action_just_released("right_click"):
		click("right", false)
