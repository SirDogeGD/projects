extends Control

var active := false
var can_unactive := true #So chat doesnt open by pressing enter, and immediately closes after releasing enter triggers _on_line_text_submitted()
var written_line_num := -1
 
func _ready():
	CHAT.text_added.connect(new_line)
	set_passive_mode()

func new_line(t):
	var l : Control = load("res://game/UI/chat/chat_ui_one.tscn").instantiate()
	l.set_text(t)
	%Lines.add_child(l)

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("Open_Chat") and not active:
		set_active_mode()
		can_unactive = false
	if event.is_action_pressed("ui_text_submit") and active and can_unactive:
		set_passive_mode()
	if event.is_action_released("ui_text_submit") and active:
		can_unactive = true

func _on_line_gui_input(event: InputEvent):
	if event.is_action_pressed("ui_up") and active:
		scroll_written_texts(true)
	if event.is_action_pressed("ui_down") and active:
		scroll_written_texts(false)

func set_passive_mode():
	active = false
	%AllContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for c : chat_ui_one in %Lines.get_children():
		c.chat_closed()
	set_scroll_to_bottom()
	if PREF.getp():
		PREF.getp().can_input = true
	
#	Line input Stuff
	%Line.clear()
	%Line.editable = false
	%Line.visible = false
	%Line.release_focus()
	
func set_active_mode():
	active = true
	%AllContainer.mouse_filter = Control.MOUSE_FILTER_PASS
	for c : chat_ui_one in %Lines.get_children():
		c.chat_opened()
	set_scroll_to_bottom()
	if PREF.getp():
		PREF.getp().can_input = false
	
#	Line input Stuff
	%Line.editable = true
	%Line.visible = true
	%Line.grab_focus()
	written_line_num = -1

func set_scroll_to_bottom():
	await get_tree().process_frame
	%ScrollContainer.scroll_vertical = %ScrollContainer.get_v_scroll_bar().max_value

func _on_line_text_submitted(_new_text: String):
	if can_unactive:
		if %Line.text != '':
			CHAT.write(%Line.text)
		set_passive_mode()

func scroll_written_texts(up : bool):
#	Change written_line_num up/down
	if up:
		written_line_num = min(written_line_num + 1, CHAT.written_texts.size() -1)
	else:
		written_line_num = max(written_line_num - 1, -1)
#	get corresponding written chat line
	if written_line_num == -1:
		%Line.clear()
	elif written_line_num <= CHAT.written_texts.size() - 1:
		%Line.text = CHAT.written_texts[written_line_num]
