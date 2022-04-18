extends Label

var cont #assigned contract

func _ready():
	text = contract_handler.make_text_progress_small(cont)
