extends Area2D
class_name hole

signal signal_entered

var entered := false

func _on_body_entered(body):
	if body == SAVE.pers and not entered:
		entered = true
		signal_entered.emit()
