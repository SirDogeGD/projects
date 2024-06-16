extends Area2D

func _ready():
	self.add_to_group("feet_detector")

func _on_body_entered(body):
	if body.is_in_group("floor"):
		print("Feet touched the floor")

func _on_body_exited(body):
	if body.is_in_group("floor"):
		print("Feet left the floor")
