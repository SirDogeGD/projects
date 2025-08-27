extends Timer

var resources := {
	"Wood Minion" : "Wood",
	"Stone Minion" : "Stone"
}

func _on_timeout() -> void:
	for key in resources:
		GameState.add_resource(resources[key], UpgradeList.get_income(key))
