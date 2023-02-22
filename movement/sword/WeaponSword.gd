extends Node2D

const DRAG_FACTOR := 15.0
const RUN_SPEED := 600.0
var can_use := true

var _velocity := Vector2.ZERO

onready var animation_player := $AnimationPlayer

func _ready():
	$UseTimer.connect("timeout", self, "reset_use")

func attack() -> void:
	if can_use:
		can_use = false
		$UseTimer.start()
		animation_player.play("slash")
		yield(animation_player, "animation_finished")
		animation_player.play("RESET")

func reset_use():
	can_use = true
