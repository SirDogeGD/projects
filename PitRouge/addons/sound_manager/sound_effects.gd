extends "res://addons/sound_manager/abstract_audio_player_pool.gd"


func play(resource: AudioStream, override_bus: String = "") -> AudioStreamPlayer:
	var audio_player = prepare(resource, override_bus)
	audio_player.call_deferred("play")
	return audio_player
