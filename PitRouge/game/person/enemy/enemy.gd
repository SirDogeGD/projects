extends person
class_name enemy

signal death

enum {
	IDLE,
	WANDER,
	ATTACK
}

var state = IDLE
var run_speed = 100
#var velocity = Vector2.ZERO
var target : person = null
var bodies_in_attack_range := []
const TOLERANCE = 4.0
const ACCELERATION = 300
const MAX_SPEED = 200

@onready var start_position = global_position
@onready var target_position = global_position

func _ready():
	super._ready()
	selected_item.connect("RESET",Callable(self,"attack_players"))

func _physics_process(delta):
	match state:
		ATTACK:
			velocity = Vector2.ZERO
			if target:
				velocity = position.direction_to(target.position) * run_speed
				selected_item.look_at(target.global_position)
				attack_players()
			move_and_slide()
		IDLE:
			state = WANDER
			update_target_position()
		WANDER:
			accelerate_to_point(target_position, ACCELERATION * delta)
			if is_at_target_position():
				state = IDLE
	
	set_velocity(velocity)
	
	super._physics_process(delta)
	
	pushback_force = lerp(pushback_force, Vector2.ZERO, delta * 10)
	set_velocity(pushback_force * 5)
	move_and_slide()

func _on_DetectRadius_body_entered(body : person):
	if body != null and body != self:
		state = ATTACK
		target = body

func _on_DetectRadius_body_exited(body : person):
	if body != null:
		state = IDLE
		target = null

func update_target_position():
	var target_vector = Vector2(randf_range(-32, 32), randf_range(-32, 32))
	target_position = start_position + target_vector

func is_at_target_position(): 
	return (target_position - global_position).length() < TOLERANCE

func accelerate_to_point(point, acceleration_scalar):
	var direction = (point - global_position).normalized()
	var acceleration_vector = direction * acceleration_scalar
	accelerate(acceleration_vector)

func accelerate(acceleration_vector):
	velocity += acceleration_vector
	velocity = velocity.limit_length(MAX_SPEED)

func on_death():
	emit_signal("death")
	await animation_player.animation_finished
	global_position = start_position
	health = health_max

func _on_AttackRadius_body_entered(body : person):
	if body != null and body != self:
		bodies_in_attack_range.append(body)

func _on_AttackRadius_body_exited(body : person):
	if body != null:
		bodies_in_attack_range.erase(body)

func attack_players():
	if $Timers/AttackTimer.is_stopped():
		$Timers/AttackTimer.start()
		selected_item.left_click()
		for b in bodies_in_attack_range:
			pass
