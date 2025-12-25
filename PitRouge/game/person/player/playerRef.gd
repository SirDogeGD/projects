extends Node
class_name playerref

signal player_ready(player)

var _player: player

func getp() -> player:
	if _player and is_instance_valid(_player):
		return _player

	_player = get_tree().get_first_node_in_group("player")
	return _player

func _on_player_spawned(p: player):
	_player = p
	player_ready.emit(p)
