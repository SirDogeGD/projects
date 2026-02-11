extends Resource 
class_name Achievement

@export var id: String
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
	pass

func unlock():
	if not unlocked:
		unlocked = true
		ACH.achievement_unlocked.emit(id)
