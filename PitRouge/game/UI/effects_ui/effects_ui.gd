extends MarginContainer

#var a : person
#var e : effects

func _ready():
	pass

func update(e : Dictionary):
	for c in %effectsContainer.get_children():
		c.queue_free()
	
	for ef in e.keys():
		if e[ef] > 0:
			var cc = CenterContainer.new()
			%effectsContainer.add_child(cc)
			var pic = TextureRect.new()
			pic.texture = load("res://img/effects/effect_" + ef + ".png")
			pic.custom_minimum_size = Vector2(40,40)
			pic.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			cc.add_child(pic)
			if e[ef] > 1:
				var numLabel := RichTextLabel.new()
				numLabel.bbcode_enabled = true
				numLabel.clip_contents = false
				numLabel.scroll_active = false
				numLabel.text = '[font_size=10][outline_size=5][outline_color=black]' + str(e[ef]) + '[/outline_color][/outline_size][/font_size]'
				pic.add_child(numLabel)
