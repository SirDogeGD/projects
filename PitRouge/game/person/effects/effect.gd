extends Node
class_name effect

var TYPE : String
var FROM : String
@onready var TIME := Timer.new()

func _ready():
	TIME.timeout.connect(end)
	TIME.wait_time = 20
	TIME.one_shot = true
	add_child(TIME)
	TIME.start()

func end():
	queue_free()

func add_time(t : float):
	TIME.start(TIME.time_left + t)
