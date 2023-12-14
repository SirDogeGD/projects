extends Node2D
class_name pickup

enum typeEnum {GOLD_INGOT, XP_BLOB}
@export var type := typeEnum.GOLD_INGOT

@onready var handler = pickupHandler.new() 
@onready var bobbing_tween = create_tween().set_loops().set_ease(Tween.EASE_OUT)

var picked := false
var target_position := Vector2()
var target_person : person #who picked me up

func _ready():
	$Icon.texture = load("res://img/pickups/" + typeEnum.keys()[type] + ".png")
	
	#bobbing animation
	bobbing_tween.tween_property(self, "position", global_position + Vector2(0, 8), 0.8)
	bobbing_tween.tween_property(self, "position", global_position + Vector2(0, -8), 0.8)
	bobbing_tween.play()

func _on_pickup_radius_body_entered(body):
	if body is person:
		target_person = body
		picked = true
		bobbing_tween.stop()

func _process(delta):
	if picked:
		global_position = global_position.lerp(target_person.global_position, 0.1)
		if global_position.distance_to(target_person.global_position) < 20:
			#audio play here
#			SOUND.play_sound(audiostream, "SFX")
			pickedUp()

#maybe could have final animation/sound or something
func pickedUp():
	handler.pickup(self, target_person)
	queue_free()

#despawn pickups after a while
func _on_despawn_timer_timeout():
	queue_free()

func random_pos(r := 200):
	var rng := RandomNumberGenerator.new()
	var x = rng.randf_range(-r, r)
	var y = rng.randf_range(-r, r)
	global_position = global_position + Vector2(x, y)
