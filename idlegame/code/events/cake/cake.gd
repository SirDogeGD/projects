extends VBoxContainer

var clicks:= 0
var last_piece = 0
var next_piece = 0
onready var tray = $CenterContainer/Cake_tray

func _ready():
	make_piece_yummy()
	for c in tray.get_children():
		c.connect("eated", self, "piece_eated")
	you.connect("health_changed", $HeartBar ,"update_health")
	you.emit_signal("health_changed", you.current_hp, you.hp, you.current_shield)

func _on_Timer_timeout():
	scene_handler.next_scene()

func make_piece_yummy():
	var pieces = tray.get_children()
	while next_piece == last_piece: #reroll until its a new piece
		next_piece = randi() % pieces.size()
	pieces[next_piece].make_yummy(make_reward())
	last_piece = next_piece

func piece_eated():
	clicks += 1
	make_piece_yummy()

func make_reward() -> Dictionary:
	return({"type":"g", "amount":(clicks + 1) * 1.5})
