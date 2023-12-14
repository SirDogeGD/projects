extends "res://addons/sound_manager/abstract_audio_player_pool.gd"


var tweens: Dictionary = {}
var track_history: PackedStringArray = []


func play(resource: AudioStream, position: float = 0.0, volume: float = 0.0, crossfade_duration: float = 0.0, override_bus: String = "") -> AudioStreamPlayer:
	stop(crossfade_duration * 2)

	var audio_player = _get_player_with_music(resource)

	# If the player already exists then just make sure the volume is right (it might have just been fading in or out)
	if audio_player != null:
		fade_volume(audio_player, audio_player.volume_db, volume, crossfade_duration)
		return audio_player

	# Otherwise we need to prep another player and handle its introduction
	audio_player = prepare(resource, override_bus)
	fade_volume(audio_player, -80.0, volume, crossfade_duration)

	# Remember this track name
	track_history.insert(0, resource.resource_path)
	if track_history.size() > 50:
		track_history.remove_at(50)

	audio_player.call_deferred("play", position)
	return audio_player


func is_playing(resource: AudioStream) -> bool:
	if resource != null:
		return _get_player_with_music(resource) != null
	else:
		return busy_players.size() > 0


func stop(fade_out_duration: float = 0.0) -> void:
	for audio_player in busy_players:
		if fade_out_duration <= 0.0:
			fade_out_duration = 0.01
		fade_volume(audio_player, audio_player.volume_db, -80, fade_out_duration)


func pause(resource: AudioStream = null) -> void:
	if resource != null:
		var audio_player = _get_player_with_music(resource)
		if is_instance_valid(audio_player):
			audio_player.stream_paused = true
	else:
		for audio_player in busy_players:
			audio_player.stream_paused = true


func resume(resource: AudioStream = null) -> void:
	if resource != null:
		var audio_player = _get_player_with_music(resource)
		if is_instance_valid(audio_player):
			audio_player.stream_paused = false
	else:
		for audio_player in busy_players:
			audio_player.stream_paused = false


func is_track_playing(resource_path: String) -> bool:
	for audio_player in busy_players:
		if audio_player.stream.resource_path == resource_path:
			return true
	return false


func get_currently_playing() -> Array[AudioStream]:
	var tracks: Array[AudioStream] = []
	for audio_player in busy_players:
		tracks.append(audio_player.stream)
	return tracks


func get_currently_playing_tracks() -> PackedStringArray:
	var tracks: PackedStringArray = []
	for audio_player in busy_players:
		tracks.append(audio_player.stream.resource_path)
	return tracks


func fade_volume(audio_player: AudioStreamPlayer, from_volume: float, to_volume: float, duration: float) -> AudioStreamPlayer:
	# Remove any tweens that might already be on this player
	_remove_tween(audio_player)

	# Start a new tween
	var tween: Tween = get_tree().create_tween().bind_node(self)

	audio_player.volume_db = from_volume
	if from_volume > to_volume:
		# Fade out
		tween.tween_property(audio_player, "volume_db", to_volume, duration).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
	else:
		# Fade in
		tween.tween_property(audio_player, "volume_db", to_volume, duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	tweens[audio_player] = tween
	tween.finished.connect(_on_fade_completed.bind(audio_player, tween, from_volume, to_volume, duration))

	return audio_player


### Helpers


func _get_player_with_music(resource: AudioStream) -> AudioStreamPlayer:
	for audio_player in busy_players:
		if audio_player.stream.resource_path == resource.resource_path:
			return audio_player
	return null


func _remove_tween(player: AudioStreamPlayer) -> void:
	if tweens.has(player):
		var fade: Tween = tweens.get(player)
		fade.kill()
		tweens.erase(player)


### Signals


func _on_fade_completed(player: AudioStreamPlayer, tween: Tween, from_volume: float, to_volume: float, duration: float):
	_remove_tween(player)

	# If we just faded out then our player is now available
	if to_volume <= -79.0:
		player.stop()
		mark_player_as_available(player)
