extends Button

func _on_pressed() -> void:
	GameState.add_money(calc_click_money())

func calc_click_money() -> float:
	var amount : float
	if GameState.upgrades.has("Better Clicks"):
		amount = GameState.upgrades["Better Clicks"] * 0.1
	return amount + 1
