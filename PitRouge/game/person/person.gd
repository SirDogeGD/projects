extends CharacterBody2D
class_name person

signal health_changed(hp : hp_data)
#signal effects_changed(effect_node : effects)
#signal perks_changed(perks : perks_slots)
signal inv_changed(inv : inventory)
signal dash_changed(dash_max : int, dash_left : int)
signal death

var SPEED : float
var is_sneaking : bool
var item_slow : bool #sword block, bow pull etc
var inv := inventory.new()
var perks := perk_slots.new()
var pushback_force := Vector2.ZERO
var stats : save_data
#Runstats
var run_stats := run_data.new()
var mega_stats := mega_data.new()

# variables containing stats + run_stats
var XP:
	get:
		return clamp(stats.xp + run_stats.xp, 0, level.new().get_total_xp_needed(self))
var GOLD:
	get:
		return stats.gold + run_stats.gold

var dmg_taken : Array[dmg_data] = []
#HP
var health := hp_data.new()
#Dashes
var dash_max := 2
var dash_left := 2: 
	set(d):
		dash_left = d
#		emit_signal("dash_changed", dash_max, dash_left)
		dash_changed.emit(dash_max, dash_left)
var DASH_REGEN_TIME := 5.0

var mystic_shards := 10
var chunk_vile := 0

@onready var selected_item : item
@onready var animation_player := $AnimationPlayer
@onready var radii : person_radii = %Radii
@onready var timers : person_timers = %Timers
@onready var dash_timer = $Timers/DashTime
@onready var dash_regen = $Timers/DashRegenTime
@onready var effect_node : effects = $Effects

func _init():
	scale.x = 0.5
	scale.y = 0.5
	inv.clear_inv()

func _ready():
	perks.guy = self #connect perks_slots funcs to self
	switch_item(0)
	mega_stats.guy = self
	run_stats.streak_changed.connect(mega_stats.update_data)
	mega_stats.refresh()
	effect_node.owner = self
	health.guy = self
	health.changed.connect(hp_changed)
	death.connect(mega_stats.mega_on_death)
	timers.owner = self

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

func on_hit(defender : person, damage : dmg_data) -> void:
	PERKS.on_hit(self, defender, damage)
	#SFX
	var sfx := [load("res://SFX/fight/hit/hit_1.ogg"), load("res://SFX/fight/hit/hit_2.ogg"), load("res://SFX/fight/hit/hit_3.ogg")]
	if damage.crit:
		sfx = [load("res://SFX/fight/hit/hit_4.mp3"), load("res://SFX/fight/hit/hit_5.mp3")]
	sfx.shuffle()
	#SOUND.play_sound(sfx[1], "SFX")
	SOUND.play_pos_sound(sfx[1], self.global_position, "SFX")

func get_hit(attacker : person, damage : dmg_data) -> void:
	animation_player.play("hit")
	add_to_dmg_taken(damage)
	health.take_dmg(damage)
	take_knock_back(attacker.global_position, damage)

func take_knock_back(source_position: Vector2, damage : dmg_data) -> void:
	
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
			num = inv.scroll(false)
		10: 
			num = inv.scroll(true)
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

func hp_changed():
	health_changed.emit(health)

func on_death():
	death.emit()
	
	#Save to stats
	stats.gold   += run_stats.gold 
	stats.xp     += run_stats.xp
	stats.kills  += run_stats.kills 
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
		if not pers == killer and not pers == null:
			pers.on_assist(self, all_dmg[pers] / self.health.maxHP * 100)
	
	#Reset stuff
	perks.clear()
	health.reset()
	dmg_taken.clear()
	run_stats.reset()
	timers.remove_all_timers()
	mega_stats.active = false
	call_info()

func call_info():
	pass

func add_to_dmg_taken(d : dmg_data):
	dmg_taken.append(d)
	#remove dmg above max health
	var totaldmg := 0.0
	for e in dmg_taken:
		totaldmg += e.amount + e.trudmg
	if totaldmg > health.maxHP:
		dmg_taken.remove_at(0)

func on_assist(b : person, p : float):
	run_stats.gold += 5 * p/100
	run_stats.xp += 5 * p/100
	call_info()

func on_kill(b : person):
	PERKS.on_kill(self, b)
#	rewards
	var r := kill_rewards.new().kill(self, b)
	run_stats.gold += r.gold
	run_stats.xp += r.xp
	run_stats.kills += 1
	run_stats.streak += 1
	bountyHandler.bump(self, b)
	mega.on_kill(mega_stats, r)
	call_info()
