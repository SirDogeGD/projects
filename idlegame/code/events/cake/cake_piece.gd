extends CenterContainer

signal eated
var yummy := true
var reward = 2

func _on_TextureRect_gui_input(event):
	if event.is_action_pressed("attack") and yummy:
#		yummy = false
		emit_signal("eated")
		$TextureRect/FCTManager.show_value(reward)

func make_yummy():
	yummy = true
