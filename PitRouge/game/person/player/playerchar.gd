extends person
class_name player

func _ready():
	super._ready()
	stats = SAVE.save
	SAVE.pers = self
	call_info()
	
	var l = level.new()
#	print(l.get_xp_of(12))
#	print(l.get_total_xp_needed(self))
#	print("xp: ", stats.xp)
#	print("level: ", l.get_level(self))
#	print("xp to next level: ", l.get_xp_to_next_level(self))

func _physics_process(delta):
	
	handle_inputs()
	
	super._physics_process(delta)
	
	selected_item.look_at(get_global_mouse_position())
	
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
	
	if Input.is_action_just_pressed("key_1"):
		switch_item(0)
	
	if Input.is_action_just_pressed("key_2"):
		switch_item(1)
	
	if Input.is_action_just_pressed("key_3"):
		switch_item(2)
	
	if Input.is_action_just_pressed("key_4"):
		switch_item(3)
	
	if Input.is_action_just_pressed("key_5"):
		switch_item(4)
	
	if Input.is_action_just_pressed("key_6"):
		switch_item(5)
	
	if Input.is_action_just_pressed("key_7"):
		switch_item(6)
	
	if Input.is_action_just_pressed("key_8"):
		switch_item(7)
	
	if Input.is_action_just_pressed("key_9"):
		switch_item(8)
	
	if Input.is_action_just_pressed("scroll_up"):
		switch_item(9)
	
	if Input.is_action_just_pressed("scroll_down"):
		switch_item(10)

func call_info():
	get_tree().call_group("info", "update", self)

func all_signals():
	emit_signal("inv_changed", inv)
	emit_signal("dash_changed", dash_max, dash_left)
	hp_signal()
	effect_node.emit_signal("effects_changed", effect_node.active)
