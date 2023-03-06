extends Label

var gold = Color( 1, 0.84, 0, 1 )
var aqua = Color( 0, 1, 1, 1 )
var red = Color(1, 0, 0)

func show_value(value, travel, duration, spread, type:String):
	text = value
	var movement = travel.rotated(randf_range(-spread/2, spread/2))
	pivot_offset = size / 2
	
	$Tween.interpolate_property(self, "position",
			position, position + movement,
			duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "modulate:a",
			1.0, 0.0, duration,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	match type.to_upper():
		"CRIT":
			modulate = red
			$Tween.interpolate_property(self, "scale",
				scale*2, scale,
				0.4, Tween.TRANS_BACK, Tween.EASE_IN)
		"G":
			modulate = gold
#			self.position += Vector2(scene_handler.rng.randi_range(-50, 50),scene_handler.rng.randi_range(-100, 100))
		"XP":
			modulate = aqua
	
	$Tween.start()
	await $Tween.tween_all_completed
	queue_free()
