extends TextureRect

func _on_pressed(event):
	if Input.is_action_just_pressed("left_click"):
		spawn_soul_fly_to_ui()

func spawn_soul_fly_to_ui():
	var soul_scene := preload("res://Resources/FloatingResource.tscn")
	var soul := soul_scene.instantiate()
	soul.type = GameState.types.SOULS
	soul.origin = "Soul Well"
	soul.position = %SoulWellMarker.global_position
	get_tree().get_root().add_child(soul)
