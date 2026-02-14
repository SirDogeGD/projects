extends Resource 
class_name Achievement

@export var id : String
@export var listen_for : String
@export var unlocked := false:
	set(t):
		unlocked = t
		if unlocked:
			ACH.save_achievements()
@export var progress := 0:
	set(p):
		progress = p
		if progress >= goal:
			unlock()
@export var goal := 1

func register():
	SIGNAL.listen.connect(handle_signal)

func handle_signal(signal_id, data):
	if signal_id == listen_for:
		progress += 1

func unlock():
	if not unlocked:
		unlocked = true
		ACH.achievement_unlocked.emit(id)
