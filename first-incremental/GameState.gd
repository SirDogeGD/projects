extends Node

var resources := {
	"Souls": 0,
	"Wood": 0
}
var upgrades := {}

func _ready() -> void:
	load_game()
	update_stat_labels()

func add_resource(type : String, amount : float):
	if resources.has(type):
		resources[type] += amount
		GameState.update_stat_labels()

func remove_resource(type: String, amount: int) -> void:
	if resources.has(type):
		resources[type] = max(resources[type] - amount, 0)
		GameState.update_stat_labels()

func get_resource(type: String) -> int:
	return resources.get(type)

func can_afford(cost: Dictionary) -> bool:
	for resource in cost.keys():
		if resources.get(resource) < cost[resource]:
			return false
	return true

func pay_cost(cost: Dictionary) -> bool:
	if not can_afford(cost):
		return false
	for resource in cost.keys():
		remove_resource(resource, cost[resource])
	return true

func save_game():
	var data = {
		"resources": GameState.resources,
		"upgrades": GameState.upgrades
	}
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()

func load_game():
	save_game()
	if not FileAccess.file_exists("user://save.json"):
		return
	var file = FileAccess.open("user://save.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()

	if data:
		GameState.resources = data["resources"]
		GameState.upgrades = data["upgrades"]

func update_stat_labels():
	get_tree().call_group("stats", "update")

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST: #handle game close -> save game
		save_game()
		get_tree().quit() # default behavior
