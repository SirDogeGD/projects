extends Control

func _ready():
	CHAT.texts_changed.connect(update_lines)
	CHAT.add_to_texts("Test")
	CHAT.add_to_texts("Test")
	CHAT.add_to_texts("Test")

func update_lines():
	for c in %Lines.get_children():
		%Lines.remove_child(c)
	
	for t in CHAT.texts:
		var l = load("res://game/UI/chat/chat_ui_one.tscn").instantiate()
		%Lines.add_child(l)
		l.set_text(t)
