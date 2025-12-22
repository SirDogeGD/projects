extends MarginContainer
class_name perk_tooltip

var data : perk_data

func _process(delta):
	if visible:
		var mouse_position = get_viewport().get_mouse_position()

		# Calculate the tooltip's position relative to the mouse cursor
		var tooltip_position = mouse_position + Vector2(10, 10)

		# Get the size of the game window
		var window_size = get_viewport_rect().size

		# Adjust the tooltip position to keep it within the visible area
		if tooltip_position.x + size.x > window_size.x:
			tooltip_position.x = window_size.x - size.x

		if tooltip_position.y + size.y > window_size.y:
			tooltip_position.y = window_size.y - size.y

		# Set the tooltip's position
		position = tooltip_position

func update(id : String, lvl : int):
	data = PINFO.perkinfo(id, PREF.getp())
	%PerkName.text = "[center][b]" + data.pname + " " + str(lvl) + "[/b][/center]"
	%PerkDesc.text = "[center]" + data.desc + "[/center]"
