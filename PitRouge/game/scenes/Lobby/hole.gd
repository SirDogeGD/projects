extends Area2D
class_name hole

signal signal_entered

var entered := false

func _on_area_entered(area):
	if area.is_in_group("feet") and not entered: 
		entered = true
		signal_entered.emit()
		#self.queue_free()
