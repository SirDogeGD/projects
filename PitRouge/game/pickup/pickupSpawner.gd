extends Node

@onready var pickupScene := preload("res://game/pickup/pickup.tscn")

var tickspeed := 2.000:
	set(t):
		%Timer.wait_time = t

func _process(delta):
	pass

func spawn():
	var p : pickup = pickupScene.instantiate()
	p.type = p.typeEnum.GOLD_INGOT
	p.random_pos(2500)
	owner.add_child(p)

func _on_timer_timeout():
	spawn()
