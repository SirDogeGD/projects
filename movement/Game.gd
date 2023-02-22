extends Node2D

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db : SQLite
var db_name = "res://DataStore/database" 

var _save: SaveGame

onready var _player := $Player
onready var _enemy := $Enemy

func _ready():
	_enemy.connect("death", self, "_save_game")
	
	_create_or_load_save()
	
	db = SQLite.new()
	commitDataToDB()
	readFromDB(1)

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

func commitDataToDB():
	db.path = db_name
	db.open_db()
	var tableName = "Perks"
	var dict : Dictionary = Dictionary()
	dict["NAME"] = "test"
	db.insert_row(tableName, dict)

func readFromDB(id : int):
	db.open_db()
	var tableName = "Perks"
	db.query("select * from " + tableName + " where ID = " + String(id) + ";")
#	for i in range(0, db.query_result.size()):
#		print("Query results: ", db.query_result[i]["NAME"])
	print(db.query_result)
	print(db.query_result[0]["DESC"])
	print(db.query_result[0]["LEVEL"])
	print(db.query_result[0]["POOL"])
	return db.query_result
