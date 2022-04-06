extends Label

var cont #assigned contract

func _ready():
	mouse_filter = Control.MOUSE_FILTER_PASS
	text = contract_handler.make_text_progress_small(cont)
