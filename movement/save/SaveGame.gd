class_name SaveGame
extends Resource

@export var player: Resource = PlayerSave.new()
@export var global_position := Vector2.ZERO

const SAVE_GAME_PATH := "user://savegame.tres"

func write_savegame():
	ResourceSaver.save(SAVE_GAME_PATH, self)

static func save_exists() -> bool:
	return ResourceLoader.exists(SAVE_GAME_PATH)

static func load_savegame() -> Resource:
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH)
	return null
