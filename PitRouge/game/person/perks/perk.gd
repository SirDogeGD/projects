extends Resource
class_name perk

@export var id : String
@export var pname : String
@export_enum("SWORD", "DEF", "GXP", "BOW", "MOVE", "HEAL") \
var slot : String
@export_enum("HIT", "HURT", "KILL", "DEATH") \
var listen_for : String
@export var desc : String
@export var nums : Array[Array]
@export_enum("WELL", "SHOP", "SPECIAL", "SEWER", "FISH", "DARK") \
var pool := "WELL"
@export var rare : bool
@export var tags : Array[String]
@export var unlock := "DEFAULT"

func register():
	SIGNAL.listen.connect(handle_signal)

func handle_signal(signal_id : String, data):
	if signal_id == listen_for:
		handle()

func handle():
	pass
