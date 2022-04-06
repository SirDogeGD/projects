extends Label

signal hovered_on(pid)
signal not_hover_on_perk()

var pid #perk id

func _ready():
	mouse_filter = Control.MOUSE_FILTER_PASS
	connect("mouse_entered", self, "on_mouse_entered")
	text = perk_info.perkinfo(pid).get_name()

func on_mouse_entered():
	emit_signal("hovered_on", pid)
