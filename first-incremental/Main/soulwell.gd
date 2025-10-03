extends TextureRect

func _on_pressed(event):
	if Input.is_action_just_pressed("left_click"):
		GameState.add_resource("Souls", UpgradeList.get_income("Soul Well"))
