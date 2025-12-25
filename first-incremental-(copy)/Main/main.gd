extends Control

func _on_ready() -> void:
	GameState.load_game()
	GameState.update_stat_labels()


func _on_soul_well_gui_input(event: InputEvent) -> void:
	pass # Replace with function body.
