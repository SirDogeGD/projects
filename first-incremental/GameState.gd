extends Node

var money: int = 0
var upgrades = {}

func add_money(amount: int):
	money += amount
	update_stat_labels()

func buy_upgrade(name: String, cost: int):
	if money >= cost:
		money -= cost
		upgrades[name] = true
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
