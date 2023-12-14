extends Node

@onready var rng := RandomNumberGenerator.new()
@onready var pickupScene := preload("res://game/pickup/pickup.tscn")

var tickspeed := 0.100

func _ready():
	%Timer.wait_time = tickspeed

func _process(delta):
	pass

func spawn():
	var p : pickup = pickupScene.instantiate()
	p.type = p.typeEnum.GOLD_INGOT
	p.random_pos(2500)
	owner.add_child(p)

func _on_timer_timeout():
	spawn()
