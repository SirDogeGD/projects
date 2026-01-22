extends Control

var active := false
 
func _ready():
	CHAT.text_added.connect(new_line)
	set_passive_mode()

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
	$ScrollContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for c : chat_ui_one in %Lines.get_children():
		c.chat_closed()
	set_scroll_to_bottom()
	
func set_active_mode():
	$ScrollContainer.mouse_filter = Control.MOUSE_FILTER_PASS
	for c : chat_ui_one in %Lines.get_children():
		c.chat_opened()
	set_scroll_to_bottom()

func set_scroll_to_bottom():
	await get_tree().process_frame
	$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
