extends TextureRect
class_name crit_mark

signal pressed

func _on_Crit_gui_input(event):
	if event.is_action_pressed("attack"):
		emit_signal("pressed")
		queue_free()

func random_pos(x, y):
	self.position += Vector2(x, y)
