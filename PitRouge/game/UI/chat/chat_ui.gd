extends Control

func _ready():
	CHAT.texts_changed.connect(update_lines)

func update_lines():
	for c in %Lines.get_children():
		%Lines.remove_child(c)
	
	for t in CHAT.texts:
		var l = RichTextLabel.new()
		l.bbcode_enabled = true
		l.fit_content = true
		l.text = t
		%Lines.add_child(l)
