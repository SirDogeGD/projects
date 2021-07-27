extends KinematicBody2D

export var speed = 300
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn()

func _physics_process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	move_and_collide(Vector2(0, 0))

func spawn():
	screen_size = get_viewport_rect().size
	position.x = 100
	position.y = 100
