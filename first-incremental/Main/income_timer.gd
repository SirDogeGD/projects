extends Timer

func _on_timeout() -> void:
	GameState.add_resource("Souls", Calculations.calc_income())
