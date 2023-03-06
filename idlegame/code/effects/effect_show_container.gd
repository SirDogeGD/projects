extends GridContainer

var effshow = load("res://code/effects/effect_show.tscn")

func _ready():
	clear()

func update_effects(effects):
	
	clear()
	
	for i in effects:
		var e = effshow.instantiate()
		e.set(i.get_name(), i.get_level())
		add_child(e)

func clear():
	for i in range(0, get_child_count()):
		get_child(i).queue_free()
