extends Node


@export var default_busses := []
@export var default_pool_size := 8


var available_players: Array[AudioStreamPlayer] = []
var busy_players: Array[AudioStreamPlayer] = []
var bus: String = "Master"


func _init(possible_busses: PackedStringArray = default_busses, pool_size: int = default_pool_size) -> void:
	bus = get_possible_bus(possible_busses)

	for i in pool_size:
		increase_pool()

func get_possible_bus(possible_busses: PackedStringArray) -> String: 
	for possible_bus in possible_busses:
		var cases: PackedStringArray = [
			possible_bus,
			possible_bus.to_lower(),
			possible_bus.to_camel_case(),
			possible_bus.to_pascal_case(),
			possible_bus.to_snake_case()
		]
		for case in cases:
			if AudioServer.get_bus_index(case) > -1:
				return case
	return "Master"

func prepare(resource: AudioStream, override_bus: String = "", volume := 1.0) -> AudioStreamPlayer:
	var audio_player: AudioStreamPlayer

	if resource is AudioStreamRandomizer:
		audio_player = get_player_with_resource(resource)

	if audio_player == null:
		audio_player = get_available_player()

	audio_player.stream = resource
	audio_player.bus = override_bus if override_bus != "" else bus
	audio_player.volume_db = linear_to_db(1.0 * volume)
	audio_player.pitch_scale = 1
	return audio_player


func get_available_player() -> AudioStreamPlayer:
	if available_players.size() == 0:
		increase_pool()
	var audio_player = available_players.pop_front()
	busy_players.append(audio_player)
	return audio_player


func get_player_with_resource(resource: AudioStream) -> AudioStreamPlayer:
	for audio_player in busy_players + available_players:
		if audio_player.stream == resource:
			return audio_player
	return null


func mark_player_as_available(audio_player: AudioStreamPlayer) -> void:
	if busy_players.has(audio_player):
		busy_players.erase(audio_player)

	if not available_players.has(audio_player):
		available_players.append(audio_player)


func increase_pool() -> void:
	var audio_player := AudioStreamPlayer.new()
	add_child(audio_player)
	available_players.append(audio_player)
	audio_player.bus = bus
	audio_player.finished.connect(_on_player_finished.bind(audio_player))


### SIGNALS


func _on_player_finished(audio_player: AudioStreamPlayer) -> void:
	mark_player_as_available(audio_player)
