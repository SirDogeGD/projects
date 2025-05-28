extends Timer

func _on_timeout() -> void:
	GameState.add_money(calc_income())

func calc_income() -> float:
	var income : float
	if GameState.upgrades.has("Clicker"):
		income = GameState.upgrades["Clicker"] * 0.1
	return income
