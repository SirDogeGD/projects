extends CenterContainer

signal eated
var yummy := false setget set_yummy
var reward = 2

func _ready():
	$TextureRect/FCTManager.z_index = 1000

func _on_TextureRect_gui_input(event):
	if event.is_action_pressed("attack") and yummy:
		set_yummy(false)
		emit_signal("eated")
		$TextureRect/FCTManager.show_value(reward)

func make_yummy(r):
	set_yummy(true)
	reward = r

func set_yummy(s:bool):
	yummy = s
	
	match s:
		true:
			$TextureRect.modulate = Color(1,0,1)
		false:
			$TextureRect.modulate = Color(1,1,1)
