extends Node
class_name main

func _ready():
	SCENE.switch_to("main_menu")
	
#func _physics_process(delta):
	#if curScene == fightScene:
		#if Input.is_action_just_pressed("tab"):
			#get_tree().paused = true
			#PUI.show()
		#if Input.is_action_just_released("tab"):
			#get_tree().paused = false
			#PUI.hide()

#func to_lobby():
	#switchscene(lobbyScene)
	#lobbyScene.jumpdown.connect(jumpdown)
#
#func jumpdown():
	#switchscene(fightScene)
