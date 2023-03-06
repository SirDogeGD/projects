extends Sprite2D

const SPRITES_MAP := {
	Vector2.RIGHT: preload("res://img/right.bmp"),
	Vector2.DOWN: preload("res://img/down.bmp"),
	Vector2.LEFT: preload("res://img/left.bmp"),
	Vector2.UP: preload("res://img/up.bmp"),
	Vector2(1.0, 1.0): preload("res://img/dr.bmp"),
	Vector2(1.0, -1.0): preload("res://img/ur.bmp"),
	Vector2(-1.0, -1.0): preload("res://img/ul.bmp"),
	Vector2(-1.0, 1.0): preload("res://img/dl.bmp")
}

var look_direction := Vector2.RIGHT

func _process(delta : float) -> void:
	var input_vector := Vector2(
		float(Input.get_action_strength("ui_right")) - float(Input.get_action_strength("ui_left")),
		float(Input.get_action_strength("ui_down")) - float(Input.get_action_strength("ui_up"))
	)
	
	if input_vector.length() > 0.0 and input_vector != look_direction:
		texture = SPRITES_MAP[input_vector]
		look_direction = input_vector
	
	position.y = sin(Time.get_ticks_msec() / 200.0) * 2.0
