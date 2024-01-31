extends "res://addons/sound_manager/abstract_audio_player_pool.gd"


func play(resource: AudioStream, override_bus: String = "", volume := 1.0) -> AudioStreamPlayer:
	var audio_player = prepare(resource, override_bus, volume)
	audio_player.call_deferred("play")
	return audio_player
