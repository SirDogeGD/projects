extends CharacterBody2D
class_name person

var SPEED := 300.0
var is_sneaking : bool
var item_slow : bool #sword block, bow pull etc
var inventory := []
var perks := []
var effects := []

@onready var item := $sword

func _physics_process(delta):
	calc_speed()
	move_and_slide()

func dash(direction : Vector2):
	
	var particles = $DashParticles
	
	if $DashTime.is_stopped() and abs(velocity.x) + abs(velocity.y) != 0:
		$DashTime.start()
		particles.emitting = true
		velocity = direction * SPEED
		await $DashTime.timeout
		particles.emitting = false

func calc_speed():
	SPEED = 300
	if not $DashTime.is_stopped():
		SPEED *= 6
	if is_sneaking:
		SPEED /= 2
	if item_slow:
		SPEED /= 2

func left_click():
	item.attack()

func right_click(pressed : bool):
	if pressed:
		item.block()
	else:
		item.unblock()