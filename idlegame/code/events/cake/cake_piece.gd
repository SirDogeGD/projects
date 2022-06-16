extends CenterContainer

signal eated
var yummy := false

func _on_Cake_Piece_mouse_entered():
	print("woah there cowboy")

func _on_TextureRect_gui_input(event):
	if event.is_action_pressed("attack") and yummy:
		emit_signal("eated")
		$TextureRect/FCT.show_value(2)
		self.queue_free()
