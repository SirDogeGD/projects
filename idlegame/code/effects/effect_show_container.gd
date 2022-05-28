extends GridContainer

export(String, "you", "enemy") var assigned

var effshow = load("res://code/effects/effect_show.tscn")

func _ready():
	clear()

func update_effects(who, effects):
	
	clear()
	
	if who == assigned:
		for i in effects:
			var e = effshow.instance()
			e.set(i.get_name(), i.get_level())
			add_child(e)

func clear():
	for i in range(0, get_child_count()):
		get_child(i).queue_free()
