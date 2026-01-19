extends Node
class_name SceneHandler

var current_scene: Node
var current_scene_id: String

const SCENES := {
	"main_menu": "res://game/scenes/main_menu/main_menu.tscn",
	"lobby": "res://game/scenes/Lobby/Lobby.tscn",
	"fight": "res://game/scenes/fight/fight.tscn"
}

func switch_to(scene_id: String):
	if current_scene:
		current_scene.queue_free()

	current_scene = load(SCENES[scene_id]).instantiate()
	add_child(current_scene)
	current_scene_id = scene_id
	
#	Add player, if needed
	if current_scene.has_node("PlayerSpawn"):
		var spawn = current_scene.get_node("PlayerSpawn")
		var p = preload("res://game/person/player/playerchar.tscn").instantiate()
		current_scene.add_child(p)
		p.global_position = spawn.global_position

func _physics_process(delta):
	if SCENE.current_scene_id == 'fight':
		if Input.is_action_just_pressed("tab"):
			PUI.show()
			get_tree().paused = true
		if Input.is_action_just_released("tab"):
			PUI.hide()
			get_tree().paused = false
