extends Area2D

func _ready():
	self.add_to_group("feet")

func _on_area_entered(area):
	if area.is_in_group("floor"):
		pass
