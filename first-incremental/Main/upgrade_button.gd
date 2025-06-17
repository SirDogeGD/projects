extends Button
class_name upgradebutton

@export var my_upgrade : String
@export var my_base_cost : int
var my_cost : int

var my_level := 0

func _on_pressed() -> void:
	GameState.buy_upgrade(my_upgrade, my_cost)
	update_cost()

func _on_ready() -> void:
	%TextLabel.text = my_upgrade
	update_cost()

func update_cost():
	if GameState.upgrades.has(my_upgrade):
		my_level = GameState.upgrades.get(my_upgrade)
	else:
		my_level = 0
	my_cost = my_base_cost * my_level * my_level * 0.2
	%CostLabel.text = str(my_cost)
