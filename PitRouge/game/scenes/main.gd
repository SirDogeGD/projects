extends Node

var curScene : Node

@onready var fightScene := preload("res://game/scenes/fight/fight.tscn").instantiate()
@onready var perkmenuScene := preload("res://game/person/perks/perk_menu/perk_menu.tscn").instantiate()

func _ready():
	curScene = fightScene
	add_child(curScene)
#	get_tree().change_scene_to_packed(fightScene)

func _physics_process(delta):
	if curScene == fightScene:
		if Input.is_action_just_pressed("tab"):
			get_tree().paused = true
			get_tree().root.add_child(perkmenuScene)
		if Input.is_action_just_released("tab"):
			get_tree().paused = false
			get_tree().root.remove_child(perkmenuScene)
