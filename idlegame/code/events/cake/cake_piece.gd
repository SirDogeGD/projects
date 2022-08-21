extends CenterContainer

signal eated
var yummy := false
var rewards:= {"type":"g",
			   "amount":0}

var img_normal = preload("res://code/events/cake/imgs/cake_piece_normal.bmp")
var img_yummy = preload("res://code/events/cake/imgs/cake_piece_yummy.bmp")
var img_choco = preload("res://code/events/cake/imgs/cake_piece_choco.bmp")

func _ready():
	$TextureRect/FCTManager.z_index = 1000

func _on_TextureRect_gui_input(event):
	if event.is_action_pressed("attack") and yummy:
		$TextureRect/FCTManager.show_value(make_reward_text(), rewards["type"])
		stats.add_stats(rewards["type"],rewards["amount"])
		set_yummy(false)
		emit_signal("eated")

func make_yummy(r):
	rewards = r
	set_yummy(true)
	
func set_yummy(s:bool):
	yummy = s
	
	match s:
		true:
			$TextureRect.texture = img_yummy
			#	is choco?
			scene_handler.rng.randomize()
			if(scene_handler.rng.randi_range(1,15) == 1):
				rewards["type"] = "xp"
				rewards["amount"] = 250
				$TextureRect.texture = img_choco
		false:
			$TextureRect.texture = img_normal

func make_reward_text() -> String:
	return(str(rewards["amount"]) + rewards["type"])
