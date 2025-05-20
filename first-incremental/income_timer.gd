extends Timer

func _on_timeout() -> void:
	if GameState.upgrades.has("AutoClicker"):
		GameState.add_money(1)
