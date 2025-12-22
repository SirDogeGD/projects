extends Node
class_name effect

signal ended

var TYPE : String
var FROM : String
var TIME := 99.0
var START := true

func _ready():
	%Timer.timeout.connect(end)
	%Timer.one_shot = true
	%Timer.wait_time = TIME
	if START:
		%Timer.start()

func end():
	ended.emit()
	queue_free()

func add_time(t : float):
	%Timer.start(%Timer.time_left + t)
