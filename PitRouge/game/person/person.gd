extends CharacterBody2D
class_name person

var SPEED := 300.0
var is_sneaking : bool
var item_slow : bool #sword block, bow pull etc
var inv := inventory
var perks := []
var effects := []
var health_max := 100
var health := health_max
var pushback_force := Vector2.ZERO

@onready var item := $sword
@onready var animation_player := $AnimationPlayer
@onready var dash_timer = $Timers/DashTime

func _init():
	scale.x = 0.5
	scale.y = 0.5

func _physics_process(delta):
	calc_speed()
	move_and_slide()

func dash(direction : Vector2):
	
	var particles = $Particles/DashParticles
	
	if dash_timer.is_stopped() and abs(velocity.x) + abs(velocity.y) != 0:
		dash_timer.start()
		particles.emitting = true
		velocity = direction * SPEED
		await dash_timer.timeout
		particles.emitting = false

func calc_speed():
	SPEED = 300
	if not dash_timer.is_stopped():
		SPEED *= 6
	if is_sneaking:
		SPEED /= 2
	if item_slow:
		SPEED /= 2

func click(key : String, pressed : bool):
	match key:
		"left":
			if pressed:
				item.attack()
			else:
				pass
		"right":
			if pressed:
				item.block()
			else:
				item.unblock()
				
func take_damage(amount: int) -> void:
	health = max(0, health - amount)
	animation_player.play("hit") 
	if health <= 0:
#		on_death()
		pass

func knock_back(source_position: Vector2) -> void:
	
	var particles := $Particles/HitParticles
	particles.rotation = get_angle_to(source_position) + PI
	pushback_force = -global_position.direction_to(source_position) * 300
