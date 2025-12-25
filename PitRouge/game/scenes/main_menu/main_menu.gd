extends Control

func _on_button_pressed():
	SCENE.switch_to("lobby")

func _on_button_quit_pressed():
	get_tree().quit()

func _enter_tree():
	UI.hide()
