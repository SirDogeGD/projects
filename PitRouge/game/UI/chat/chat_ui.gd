extends Control

var active := false

func _ready():
	set_passive_mode()
	CHAT.texts_changed.connect(update_lines)
	CHAT.add_to_texts("Test")
	CHAT.add_to_texts("Test")
	CHAT.add_to_texts("Test")
	CHAT.add_to_texts("Test")
	CHAT.add_to_texts("Test")
	CHAT.add_to_texts("Test")
	CHAT.add_to_texts("Test")
	CHAT.add_to_texts("Test")
	CHAT.add_to_texts("Test")
	CHAT.add_to_texts("Test")
	CHAT.add_to_texts("Test")
	CHAT.add_to_texts("Test")
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

func _unhandled_input(event):
	if event.is_action_pressed("Toggle_Chat"):
		active = !active
		if active:
			set_active_mode()
			print("ACTIVE")
		else:
			print("PASSIVE")
			set_passive_mode()

func set_passive_mode():
	$ScrollContainer.vertical_scroll_mode = false
	$ScrollContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func set_active_mode():
	$ScrollContainer.vertical_scroll_mode = true
	$ScrollContainer.mouse_filter = Control.MOUSE_FILTER_PASS
