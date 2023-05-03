extends CharacterBody2D
class_name person

signal health_changed
signal effects_changed
signal perks_changed
signal inv_changed(inv)
signal dash_changed(dash_max, dash_left)

var SPEED := 300.0
var is_sneaking : bool
var item_slow : bool #sword block, bow pull etc
var inv := inventory.new()
var perks := []
var effects := []
var health_max := 100
var health := health_max
var pushback_force := Vector2.ZERO
#Dashes
var dash_max := 2
var dash_left := 2: 
	set(d):
		dash_left = d
		emit_signal("dash_changed", dash_max, dash_left)
var DASH_REGEN_TIME := 5.0

@onready var selected_item : item
@onready var animation_player := $AnimationPlayer
@onready var dash_timer = $Timers/DashTime
@onready var dash_regen = $Timers/DashRegenTime

func _init():
	scale.x = 0.5
	scale.y = 0.5
	inv.clear_inv()

func _ready():
	switch_item(0)
	dash_regen.wait_time = DASH_REGEN_TIME
	
func _physics_process(delta):
	calc_speed()
	move_and_slide()

func dash(direction : Vector2):
	
	var particles = $Particles/DashParticles
	
	if dash_timer.is_stopped() and abs(velocity.x) + abs(velocity.y) != 0 and dash_left > 0:
		dash_timer.start()
		
		#Dash Regen
		dash_left -= 1
		dash_regen.start()
		
		particles.emitting = true
		velocity = direction * SPEED
		await dash_timer.timeout
		particles.emitting = false

func calc_speed():
	SPEED = 300
	#1% speed per effect
	SPEED += $Effects.active["SPEED"] * 3
	#multiplier
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
				
func get_hit(attacker : person, dmg : float) -> void:
	if health <= 0:
#		on_death()
		pass
	knock_back(attacker.global_position, false)
	animation_player.play("hit") 

func knock_back(source_position: Vector2, crit : bool) -> void:
	
	var hit_particles := $Particles/HitParticles
	var crit_particles := $Particles/CritParticles
	var particles := hit_particles
	
	hit_particles.visible = false
	crit_particles.visible = false
	
	if crit:
		particles = crit_particles
	
	particles.visible = true
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
	emit_signal("inv_changed", inv)

func _on_dash_regen_time_timeout():
	dash_left = min(dash_max, dash_left + 1)
	if dash_left < dash_max:
		dash_regen.start()
