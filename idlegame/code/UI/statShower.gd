extends CenterContainer
class_name Stat_shower

@export var type # (String, "g", "xp", "r", "st")

func _ready():
	update()

func type(t):
	type = t
	update()

func update():
	match type:
		"g":
			$Label.set_text("Gold: " + str(stats.gold))
			$Label.add_theme_color_override("font_color", Color( 1, 0.84, 0, 1 ))
		"xp":
			$Label.set_text("XP: " + str(stats.xp))
			$Label.add_theme_color_override("font_color", Color( 0.25, 0.88, 0.82, 1 ))
		"r":
			$Label.set_text("Renown: " + str(stats.renown))
			$Label.add_theme_color_override("font_color", Color( 0.56, 0.93, 0.56, 1 ))
		"st":
			$Label.set_text("Streak: " + str(you.streak))
		_:
			pass
