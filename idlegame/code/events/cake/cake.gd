extends CenterContainer



func _ready():
	pass

func _on_Timer_timeout():
	scene_handler.next_scene()
