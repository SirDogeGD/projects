extends Timer

func _on_timeout() -> void:
	GameState.save_game()
