extends Button

func _on_pressed() -> void:
	GameState.add_resource("Souls", Calculations.calc_click_souls())
