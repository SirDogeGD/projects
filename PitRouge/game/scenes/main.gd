extends Node
class_name main

func _ready():
	ACH.reset_achievements()
	SCENE.switch_to("main_menu")
	
func _physics_process(delta):
	pass
