extends Area2D

func _ready():
	pass # Replace with function body.

func _on_spike_body_entered(body):
	if(body.has_method("spawn") == true):
		body.spawn()
