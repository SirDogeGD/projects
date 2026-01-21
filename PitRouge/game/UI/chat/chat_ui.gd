extends Control

var active := false
 
func _ready():
	set_passive_mode()
	CHAT.text_added.connect(new_line)
	CHAT.add_to_texts("Test1")
	CHAT.add_to_texts("Test2")
	CHAT.add_to_texts("Test3")
	CHAT.add_to_texts("Test4")
	CHAT.add_to_texts("Test5")
	CHAT.add_to_texts("Test6")
	CHAT.add_to_texts("Test7")
	CHAT.add_to_texts("Test8")
	CHAT.add_to_texts("Test9")
	CHAT.add_to_texts("Test9")
	CHAT.add_to_texts("Test9")
	CHAT.add_to_texts("Test9")
	CHAT.add_to_texts("Test9")
	CHAT.add_to_texts("Test9")
	CHAT.add_to_texts("Test9")
	CHAT.add_to_texts("Test9")
	CHAT.add_to_texts("Test9")
	CHAT.add_to_texts("Test9")
	CHAT.add_to_texts("Test9")
	CHAT.add_to_texts("Test9")
	CHAT.add_to_texts("Test9")
	CHAT.add_to_texts("Test9")

func new_line(t):
	var l : Control = load("res://game/UI/chat/chat_ui_one.tscn").instantiate()
	l.set_text(t)
	%Lines.add_child(l)

func _unhandled_input(event):
	if event.is_action_pressed("Toggle_Chat"):
		active = !active
		if active:
			set_active_mode()
			PREF.getp().can_input = false
		else:
			set_passive_mode()
			PREF.getp().can_input = true

func set_passive_mode():
	$ScrollContainer.vertical_scroll_mode = 0
	$ScrollContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for c : chat_ui_one in %Lines.get_children():
		c.chat_closed()
	
func set_active_mode():
	%ScrollContainer.vertical_scroll_mode = 3
	$ScrollContainer.mouse_filter = Control.MOUSE_FILTER_PASS
	for c : chat_ui_one in %Lines.get_children():
		c.chat_opened()
