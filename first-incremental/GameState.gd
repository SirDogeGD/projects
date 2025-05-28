extends Node

var money: float = 0:
	set(m):
		money = m
		update_stat_labels()
var upgrades = {}

func _ready() -> void:
	load_game()
	update_stat_labels()

func add_money(amount : float):
	money += amount

func buy_upgrade(name: String, cost: int):
	if money >= cost:
		money -= cost
		if upgrades.has(name):
			upgrades[name] += 1
		else:
			upgrades[name] = 1
		update_stat_labels()
		return true
	return false

func save_game():
	var data = {
		"money": GameState.money,
		"upgrades": GameState.upgrades
	}
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()

func load_game():
	if not FileAccess.file_exists("user://save.json"):
		return
	var file = FileAccess.open("user://save.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()

	if data:
		GameState.money = data["money"]
		GameState.upgrades = data["upgrades"]

func update_stat_labels():
	get_tree().call_group("stats", "update")

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST: #handle game close -> save game
		save_game()
		get_tree().quit() # default behavior
