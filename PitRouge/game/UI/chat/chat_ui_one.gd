extends Control
class_name chat_ui_one

var new := true

func set_text(t : String):
	%TLabel.text = t

func chat_opened():
	if new:
		%FadeTimer.paused = true
		%DeleteTimer.paused = true
	else:
		%AnimationPlayer.stop()
		visible = true
		modulate = Color(1.0, 1.0, 1.0)

func chat_closed():
	if new:
		%FadeTimer.paused = false
		%DeleteTimer.paused = false
	else:
		visible = false
		modulate = Color(1.0, 1.0, 1.0, 0)

func _on_fade_timer_timeout():
	new = false
	%AnimationPlayer.play("fade_out")

func _on_delete_timer_timeout():
	self.queue_free()
