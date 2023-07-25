extends Node
class_name main

var curScene : Node

@onready var fightScene := preload("res://game/scenes/fight/fight.tscn").instantiate()

func _ready():
	curScene = fightScene
	add_child(curScene)
	PUI.new_choice()
	PUI.visible = false

func _physics_process(delta):
	if curScene == fightScene:
		if Input.is_action_just_pressed("tab"):
			get_tree().paused = true
			PUI.visible = true
		if Input.is_action_just_released("tab"):
			get_tree().paused = false
			PUI.visible = false

func start():
	pass
