extends CharacterBody2D
class_name person

signal health_changed
signal effects_changed
signal perks_changed
signal inv_changed(inv)

var SPEED := 300.0
var is_sneaking : bool
var item_slow : bool #sword block, bow pull etc
var inv := inventory.new()
var perks := []
var effects := []
var health_max := 100
var health := health_max
var pushback_force := Vector2.ZERO

@onready var selected_item : item
@onready var animation_player := $AnimationPlayer
@onready var dash_timer = $Timers/DashTime

func _init():
	scale.x = 0.5
	scale.y = 0.5
	inv.clear_inv()

func _ready():
	switch_item(0)

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
				selected_item.left_click()
			else:
				pass
		"right":
			if pressed:
				selected_item.right_click()
			else:
				selected_item.stop_right_click()
				
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

func switch_item(num : int):
	match num:
		0,1,2,3,4,5,6,7,8:
			inv.select(num)
		9:
			inv.scroll(true)
		10: 
			inv.scroll(false)
	remove_child(selected_item)
	var new_item = inv.items[num].instantiate()
	add_child(new_item)
	selected_item = new_item
	selected_item.owner = self
