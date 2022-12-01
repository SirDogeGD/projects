extends KinematicBody2D
class_name enemy

signal death

enum {
	IDLE,
	WANDER,
	ATTACK
}

export var health_max := 100

var state = IDLE
var health := health_max
var run_speed = 100
var velocity = Vector2.ZERO
var player = null
var pushback_force := Vector2.ZERO
const TOLERANCE = 4.0
const ACCELERATION = 300
const MAX_SPEED = 50

onready var start_position = global_position
onready var target_position = global_position
onready var animation_player := $AnimationPlayer
onready var hit_particles := $HitParticles

func take_damage(amount: int) -> void:
	health = max(0, health - amount)
	animation_player.play("hit")
	if health <= 0:
		on_death()

func _physics_process(delta):
	match state:
		ATTACK:
			velocity = Vector2.ZERO
			if player:
				velocity = position.direction_to(player.position) * run_speed
			pushback_force = lerp(pushback_force, Vector2.ZERO, delta * 10)
			move_and_slide(pushback_force * 5)
		IDLE:
			state = WANDER
			update_target_position()
		WANDER:
			accelerate_to_point(target_position, ACCELERATION * delta)

			if is_at_target_position():
				state = IDLE
	velocity = move_and_slide(velocity)

func _on_DetectRadius_body_entered(body : player):
	if body != null:
		state = ATTACK
		player = body

func _on_DetectRadius_body_exited(body : player):
	if body != null:
		state = IDLE
		player = null

func knock_back(source_position: Vector2) -> void:
	hit_particles.rotation = get_angle_to(source_position) + PI
	pushback_force = -global_position.direction_to(source_position) * 300
	print(pushback_force)

func update_target_position():
	var target_vector = Vector2(rand_range(-32, 32), rand_range(-32, 32))
	target_position = start_position + target_vector

func is_at_target_position(): 
	return (target_position - global_position).length() < TOLERANCE

func accelerate_to_point(point, acceleration_scalar):
	var direction = (point - global_position).normalized()
	var acceleration_vector = direction * acceleration_scalar
	accelerate(acceleration_vector)

func accelerate(acceleration_vector):
	velocity += acceleration_vector
	velocity = velocity.clamped(MAX_SPEED)

func on_death():
	emit_signal("death")
	$Sprite.visible = false
	yield(animation_player, "animation_finished")
	self.queue_free()
