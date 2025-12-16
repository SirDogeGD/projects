extends Node
class_name SceneHandler

var current_scene: Node

const SCENES := {
	"main_menu": "res://game/scenes/main_menu/main_menu.tscn",
	"lobby": "res://game/scenes/Lobby/Lobby.tscn",
	"fight": "res://game/scenes/fight/fight.tscn"
}

func switch_to(scene_id: String):
	if current_scene:
		current_scene.queue_free()

	var scene = load(SCENES[scene_id]).instantiate()
	add_child(scene)
	current_scene = scene
