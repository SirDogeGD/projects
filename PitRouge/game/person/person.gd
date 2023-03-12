extends CharacterBody2D
class_name person

var SPEED := 300.0

func _physics_process(delta):
	pass

func dash(direction : Vector2):
	if $DashTime.is_stopped() and velocity.x + velocity.y != 0:
		$DashTime.start()
		$DashParticles.emitting = true
		SPEED *= 6
		velocity = direction * SPEED
		await $DashTime.timeout
		$DashParticles.emitting = false
		SPEED /= 6
