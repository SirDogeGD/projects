extends CharacterBody2D
class_name person

signal health_changed(hp : hp_data)
#signal effects_changed(effect_node : effects)
#signal perks_changed(perks : perks_array)
signal inv_changed(inv : inventory)
signal dash_changed(dash_max : int, dash_left : int)
signal death

var SPEED : float
var is_sneaking : bool
var item_slow : bool #sword block, bow pull etc
var inv := inventory.new()
var perks := perks_array.new()
var pushback_force := Vector2.ZERO
var stats : save_data
#Runstats
var run_stats = {
	"streak" : 0.0,
	"gold" : 0.0,
	"xp" : 0.0,
	"kills" : 0
}
var dmg_taken : Array[dmg_data] = []
#HP
var health_max := 20
var health : float = health_max:
	set(hp):
		health = clamp(hp, 0, health_max)
		if health == 0:
			on_death()
		hp_signal()
#Shield
var shield_max := 20
var shield := 0.0:
	set(hp):
		shield = clamp(hp, 0, shield_max)
		hp_signal()
#Bounty
var bounty_max := 5000
var bounty := 0
#Dashes
var dash_max := 2
var dash_left := 2: 
	set(d):
		dash_left = d
		emit_signal("dash_changed", dash_max, dash_left)
var DASH_REGEN_TIME := 5.0

var mystic_shards := 10
var chunk_vile := 0

@onready var selected_item : item
@onready var animation_player := $AnimationPlayer
@onready var dash_timer = $Timers/DashTime
@onready var dash_regen = $Timers/DashRegenTime
@onready var effect_node : effects = $Effects

func _init():
	scale.x = 0.5
	scale.y = 0.5
	inv.clear_inv()

func _ready():
	perks.guy = self #connect perks_array funcs to self
	switch_item(0)
	
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
	SPEED += effect_node.get_boost("SPEED")
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

func get_hit(attacker : person, damage : dmg_data) -> void:
	animation_player.play("hit")
	add_to_dmg_taken(damage)
	take_dmg(damage)
	knock_back(attacker.global_position, damage)

func take_dmg(d : dmg_data):
	if d.amount <= shield: #hit does less damage than the amount of shield left
		shield -= d.amount
	else:
		var new_amount = d.amount - shield #normal case, new_amount because of dmg_taken
		shield = 0
		health -= new_amount
	health -= d.trudmg

func knock_back(source_position: Vector2, damage : dmg_data) -> void:
	
	var hit_particles := $Particles/HitParticles
	var crit_particles := $Particles/CritParticles
	var particles := hit_particles
	
	hit_particles.visible = false
	crit_particles.visible = false
	
	if damage.crit:
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
	var new_item = inv.items[num]
	add_child(new_item)
	selected_item = new_item
	selected_item.owner = self
	emit_signal("inv_changed", inv)

func _on_dash_regen_time_timeout():
	dash_left = min(dash_max, dash_left + 1)
	if dash_left < dash_max:
		dash_regen.start()

func hp_signal():
	var hp = hp_data.new()
	hp.curHP = health
	hp.maxHP = health_max
	hp.curSH = shield
	emit_signal("health_changed", hp)

func on_death():
	emit_signal("death")
	
	#Save to stats
	stats.gold   += run_stats["gold"]
	stats.xp     += run_stats["xp"]
	stats.kills  += run_stats["kills"]
	stats.deaths += 1
	if is_instance_of(self, player):
		SAVE.save_data()
	
	#Determine killer / assists
	var killer := dmg_taken[-1].attacker #last person to do dmg
	var all_dmg = {} # Dictionary to store [attacker, damage] pairs

	for e in dmg_taken:
		if e.attacker not in all_dmg:
			all_dmg[e.attacker] = 0.0
		all_dmg[e.attacker] += e.amount + e.trudmg
	
	#Activate kill/assists
	killer.on_kill(self)
	for pers in all_dmg.keys():
		if not pers == killer:
			pers.on_assist(self, all_dmg[pers] / self.health_max * 100)
	
	#Reset stuff
	perks.clear()
	health = health_max
	shield = 0
	bounty = 0
	dmg_taken.clear()
	for key in run_stats.keys():
		run_stats[key] = 0
	call_info()

func call_info():
	pass

func add_to_dmg_taken(d : dmg_data):
	dmg_taken.append(d)
	#remove dmg above max health
	var totaldmg := 0.0
	for e in dmg_taken:
		totaldmg += e.amount + e.trudmg
	if totaldmg > health_max:
		dmg_taken.remove_at(0)

func on_assist(b : person, p : float):
	run_stats["gold"] += 5 * p/100
	run_stats["xp"] += 5 * p/100
	call_info()

func on_kill(b : person):
	var r := rewards.new()
	var kr = r.kill(self, b)
	run_stats["gold"] += kr["G"]
	run_stats["xp"] += kr["X"]
	run_stats["kills"] += 1
	run_stats["streak"] += 1
	call_info()

#PERK RADII
func add_radius(id : String, r := 10):
	r *= 100 #1 block = 100 pixels
	
	var area := Area2D.new() #create area2d
	area.name = "perk_" + id
	%Radii.add_child(area)
	
	var col := CollisionShape2D.new() #create shape
	var shape = CircleShape2D.new()
	shape.radius = r
	col.shape = shape
	area.add_child(col)

func remove_radius(id : String):
	var radius_to_remove := get_node_or_null("Radii/perk_" + id)
	if radius_to_remove != null:
		remove_child(radius_to_remove)
		radius_to_remove.queue_free()

#get persons in range
func gpir(id : String) -> Array[person]:
	var persons_in_range : Array[person]
	var area := get_node_or_null("Radii/perk_" + id)
	if area != null:
		for body in area.get_overlapping_bodies(): #get persons in range
			if body != self and body is person:
				persons_in_range.append(body)	
	return persons_in_range

#PERK TIMERS
func add_timer(id : String, t := 1):
	var timer := Timer.new()
	timer.name = "timer_" + id
	timer.wait_time = t
	%Timers.add_child(timer)

func get_timer(id : String) -> Timer:
	var timer := %Timers.get_node_or_null("timer_" + id)
	return timer

func remove_timer(id : String):
	var timer_to_remove := get_node_or_null("Timers/perk_" + id)
	if timer_to_remove != null:
		remove_child(timer_to_remove)
		timer_to_remove.queue_free()
