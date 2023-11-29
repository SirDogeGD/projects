extends Node2D
class_name pickup

enum typeEnum {GOLD, XP}
@export var type : typeEnum

@onready var handler = pickupHandler.new() 

var picked := false
var target_position := Vector2()
var target_person : person #who picked me up

func _on_pickup_radius_body_entered(body):
	if body is person:
		target_person = body
		picked = true

func _process(delta):
	if picked:
		global_position = global_position.lerp(target_person.global_position, 0.1)
		if global_position.distance_to(target_person.global_position) < 10:
			pickedUp()

#maybe could have final animation/sound or something
func pickedUp():
	handler.pickup(self, target_person)
	queue_free()
