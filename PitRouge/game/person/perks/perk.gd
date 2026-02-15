extends Resource
class_name perk

@export var id : String
@export var listen_for : String

func handle_signal(signal_id, data):
	if signal_id == listen_for:
		handle()

func handle():
	pass
