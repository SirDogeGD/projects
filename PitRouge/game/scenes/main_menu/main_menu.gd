extends Control

signal start

func _on_button_pressed():
	start.emit()

func _on_button_quit_pressed():
	get_tree().quit()
