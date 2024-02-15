extends Node
class_name run_data
#stores data of current run

signal streak_changed(s : float)

var streak := 0.0:
	set(s):
		streak = s
		streak_changed.emit(streak)
var gold := 0.0
var xp := 0.0
var kills := 0

func reset():
	streak = 0
	gold = 0
	xp = 0
	kills = 0
