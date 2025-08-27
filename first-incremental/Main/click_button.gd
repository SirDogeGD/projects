extends Button

func _on_pressed() -> void:
	GameState.add_resource("Souls", UpgradeList.get_income("Soul Well"))
