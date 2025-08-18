extends Node
class_name upgrade_list

var list := {
	"Soul Well" : {
		"Cost" : [
			{"Wood" : 10},
			{"Stone" : 30},
			{"Wood" : 1000, "Stone" : 500},
		]
	},
	"Wood Minion" : {
		"Cost" : [
			{"Souls" : 80},
			{"Souls" : 360},
			{"Souls" : 2540, "Stone" : 680},
		]
	},
	"Stone Minion" : {
		"Cost" : [
			{"Souls" : 6030},
			{"Souls" : 18060},
			{"Souls" : 264440},
		]
	}
}

func get_upgrade_cost(name : String) -> Dictionary:
	if list.has(name):
		return list.get(name)["Cost"][GameState.get_upgrade_level(name)]
	else:
		return {}

func get_cost_text(name : String) -> String:
	var text : String
	if list.has(name):
		var cost := get_upgrade_cost(name)
		for r in cost:
			text += r + ': ' + str(cost[r])
		return text
	else:
		return "upgrade not found"
