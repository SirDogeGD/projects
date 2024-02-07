extends Node
class_name run_data
#stores data of current run

signal mega_activated(id : String)
signal streak_changed(s : float)

var streak := 0.0:
	set(s):
		streak_changed.emit(s)
var gold := 0.0
var xp := 0.0
var kills := 0
var cur_mega := "OVRDRV"
var mega_active := false:
	set(state):
		if state == true:
			mega_activated.emit(cur_mega)

func reset():
	streak = 0
	gold = 0
	xp = 0
	kills = 0
	mega_active = false
