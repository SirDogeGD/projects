extends Node2D

const DRAG_FACTOR := 15.0
const RUN_SPEED := 600.0

var _velocity := Vector2.ZERO

@onready var animation_player := $AnimationPlayer

func _ready():
	pass

func attack() -> void:
	#cant attack while blocking
	if not animation_player.current_animation == "block": 
		animation_player.play("RESET")
		animation_player.play("stab")
		await animation_player.animation_finished
		animation_player.play("RESET")

func block():
	#set persons item_slow true
	if owner.get("item_slow") != null:
		owner.item_slow = true
	#play block "animation"
	animation_player.play("RESET")
	animation_player.play("block")

func unblock():
	#set persons item_slow false
	if owner.get("item_slow") != null:
		owner.item_slow = false
	#unblock
	if animation_player.current_animation == "block":
		animation_player.play("RESET")
