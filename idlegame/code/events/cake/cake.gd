extends CenterContainer

var clicks:= 0

func _ready():
	make_piece_yummy()
	for c in $GridContainer.get_children():
		c.connect("eated", self, "piece_eated")

func _on_Timer_timeout():
	scene_handler.next_scene()

func make_piece_yummy():
	var pieces = $GridContainer.get_children()
	pieces[randi() % pieces.size()].make_yummy(10)

func piece_eated():
	clicks += 1
	make_piece_yummy()
