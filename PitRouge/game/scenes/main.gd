extends Node
class_name main

var curScene : Node

@onready var fightScene := preload("res://game/scenes/fight/fight.tscn").instantiate()
@onready var mainMenuScene := preload("res://game/scenes/main_menu/main_menu.tscn").instantiate()
@onready var lobbyScene := preload("res://game/scenes/Lobby/Lobby.tscn").instantiate()

func _ready():
	curScene = mainMenuScene
	add_child(curScene)
	mainMenuScene.start.connect(start)

func _physics_process(delta):
	if curScene == fightScene:
		if Input.is_action_just_pressed("tab"):
			get_tree().paused = true
			PUI.show()
		if Input.is_action_just_released("tab"):
			get_tree().paused = false
			PUI.hide()

func switchscene(scene : Node):
	remove_child(curScene)
	curScene = scene
	add_child(curScene)

func start():
	switchscene(lobbyScene)
