extends TextureRect

func _on_pressed(event):
	if Input.is_action_just_pressed("left_click"):
		spawn_soul_fly_to_ui()
		#GameState.add_resource("Souls", UpgradeList.get_income("Soul Well"))

func spawn_soul_fly_to_ui():
	var soul_scene = preload("res://Resources/floating_resource.gd")
	var soul = soul_scene.new()
	soul.type = GameState.types.SOULS
	soul.origin = "Soul Well"
	get_tree().get_root().add_child(soul)
