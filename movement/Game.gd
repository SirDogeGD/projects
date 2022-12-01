extends Node2D

var _save: SaveGame

onready var _player := $Player
onready var _enemy := $Enemy

func _ready():
	_enemy.connect("death", self, "_save_game")
	
	_create_or_load_save()

func _create_or_load_save() -> void:
	if SaveGame.save_exists():
		_save = SaveGame.load_savegame()
	else:
		_save = SaveGame.new()
		_save.global_position = _player.global_position
		_save.kills = 0

		_save.write_savegame()
	
	_player.global_position = _save.global_position
	_player.stats = _save.player

func _save_game() -> void:
	_save.global_position = _player.global_position
	_save.write_savegame()
