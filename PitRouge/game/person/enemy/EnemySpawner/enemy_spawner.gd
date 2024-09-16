extends Node2D
 
@onready var enemyScene := preload("res://game/person/enemy/enemy.tscn")

var tickspeed := 10.000:
	set(t):
		%Timer.wait_time = t

func spawn():
	var distance_from_player := 1000
	var valid_pos := false
	var e : enemy = enemyScene.instantiate()
	var spawn_position := Vector2()
	var player_pos := SAVE.pers.global_position
	
	while not valid_pos:
		spawn_position = Vector2(
			player_pos.x + randf_range(-1000, 1000),
			player_pos.y + randf_range(-1000, 1000))
		#distance from player
		if spawn_position.distance_to(player_pos) > distance_from_player:
			valid_pos = true
			#distance from other enemies
			for en in get_tree().get_nodes_in_group("enemy"):
				if spawn_position.distance_to(en.global_position) < distance_from_player / 2:
					valid_pos = false
					
	e.global_position = spawn_position
	owner.add_child(e)
	
	tickspeed = new_time()

func _on_timer_timeout():
	spawn()
	despawn_far_enemy()

func despawn_far_enemy():
	for en in get_tree().get_nodes_in_group("enemy"):
		if SAVE.pers.global_position.distance_to(en.global_position) > 3000:
			en.queue_free()

#update enemy spawn rate
func new_time() -> float:
	var min_timer_speed = 0.1
	var max_timer_speed = 10.0
	var streak_factor = 0.05
	var streak = SAVE.pers.run_stats.streak
	return max(max_timer_speed - streak * streak_factor, min_timer_speed)
