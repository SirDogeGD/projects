extends CharacterBody2D
class_name person

var stats: PlayerSave : set = set_stats

@export var speed := 400.0
@export var health_max := 100

var health := health_max
var pushback_force := Vector2.ZERO

@onready var sword := $WeaponSword
@onready var animation_player := $AnimationPlayer
@onready var hit_particles := $HitParticles

func set_stats(new_stats: PlayerSave) -> void:
	stats = new_stats
	set_physics_process(stats != null)

func knock_back(source_position: Vector2) -> void:
	hit_particles.rotation = get_angle_to(source_position) + PI
	pushback_force = -global_position.direction_to(source_position) * 300

func take_damage(amount: int) -> void:
	health = max(0, health - amount)
	animation_player.play("hit")
	if health <= 0:
		on_death()

func on_death():
	pass
