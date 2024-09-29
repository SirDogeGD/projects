extends Node
class_name main

var curScene : Node

@onready var fightScene := preload("res://game/scenes/fight/fight.tscn").instantiate()
@onready var mainMenuScene := preload("res://game/scenes/main_menu/main_menu.tscn").instantiate()
@onready var lobbyScene := preload("res://game/scenes/Lobby/Lobby.tscn").instantiate()

func _ready():
	curScene = mainMenuScene
	add_child(curScene)
	mainMenuScene.start.connect(to_lobby)
	SAVE.pers.death.connect(to_lobby)

func _physics_process(delta):
	if curScene == fightScene:
		if Input.is_action_just_pressed("tab"):
			get_tree().paused = true
			PUI.show()
		if Input.is_action_just_released("tab"):
			get_tree().paused = false
			PUI.hide()

func switchscene(scene : Node):
	var p := SAVE.pers
	if p.get_parent() == curScene:
		curScene.remove_child(SAVE.pers)
	
	remove_child(curScene)
#	print("old scene: ", curScene.name)
	curScene = scene
	#print("new scene: ", curScene.name)
	add_child(curScene)
	if curScene.has_method("_ready"):
		curScene._ready()
	
	SAVE.pers = p

func to_lobby():
	switchscene(lobbyScene)
	lobbyScene.jumpdown.connect(jumpdown)

func jumpdown():
	switchscene(fightScene)
