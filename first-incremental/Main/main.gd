extends Control

func _on_ready() -> void:
	GameState.load_game()
	GameState.update_stat_labels()
