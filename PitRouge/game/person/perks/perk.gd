extends Resource
class_name perk

@export var id : String
@export var listen_for : String
@export var pname : String
@export var desc : String
@export var nums : Array[Array]
@export var pool : String
@export var rare : bool
@export var tags : Array[String]
@export var unlock : String

func register():
	SIGNAL.listen.connect(handle_signal)

func handle_signal(signal_id : String, data):
	if signal_id == listen_for:
		handle()

func handle():
	pass
