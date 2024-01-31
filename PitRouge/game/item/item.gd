extends Node
class_name item

var itemname := ""
var stack_size := 1
var max_stack_size := 1
var damage := 1.0
var my_left_sound : AudioStream

@onready var animation_player := $AnimationPlayer

func left_click():
#	SOUND.play_sound(my_left_sound, "SFX")
	SOUND.play_pos_sound(my_left_sound, self.global_position, "SFX")

func right_click():
	pass

func stop_right_click():
	pass

func get_pic() -> CompressedTexture2D:
	return $Sprite2D.texture
