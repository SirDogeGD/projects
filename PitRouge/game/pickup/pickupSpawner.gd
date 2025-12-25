extends Node

@onready var pickupScene := preload("res://game/pickup/pickup.tscn")

var tickspeed := 2.000:
	set(t):
		%Timer.wait_time = t
		
func _ready():
	PREF.player_ready.connect(start, CONNECT_ONE_SHOT)
	
func start(_p : player):
	%Timer.start()

func spawn():
	var p : pickup = pickupScene.instantiate()
	p.type = p.typeEnum.GOLD_INGOT
	p.random_pos(2500)
	owner.add_child(p)

func _on_timer_timeout():
	spawn()
	despawn_far_pickup()

func despawn_far_pickup():
	for pi in get_tree().get_nodes_in_group("pickup"):
		if PREF.getp():
			if PREF.getp().global_position.distance_to(pi.global_position) > 4000:
				pi.queue_free()
