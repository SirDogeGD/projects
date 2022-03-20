extends Control

export(String, "g", "xp", "r") var type

func type(t):
	self.type = t
	update()

func update():
	match type:
		"g":
			$Label.set_text("Gold: " + str(stats.gold))
		"xp":
			$Label.set_text("XP: " + str(stats.xp))
		"r":
			$Label.set_text("Renown: " + str(stats.renown))
		_:
			pass

func _process(delta):
	update()
