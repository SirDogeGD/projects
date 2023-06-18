extends MarginContainer

#var a : person
#var e : effects

func _ready():
	pass

func update(e : Dictionary):
	print("updating")
	for c in %effectsContainer.get_children():
		c.queue_free()
	
	for ef in e.keys():
		if e[ef] > 0:
			var pic = TextureRect.new()
			pic.texture = load("res://img/effects/effect_" + ef + ".png")
			pic.custom_minimum_size = Vector2(40,40)
			pic.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			%effectsContainer.add_child(pic)
