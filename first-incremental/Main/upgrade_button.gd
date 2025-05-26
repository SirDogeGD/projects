extends Button
class_name upgradebutton

@export var my_upgrade : String#:
	#set(t):
		#%TextLabel.text = t
@export var my_cost : int#:
	#set(c):
		#%CostLabel.text = str(c)

var my_level := 0

func _on_pressed() -> void:
	GameState.buy_upgrade(my_upgrade, my_cost)

func _on_ready() -> void:
	%TextLabel.text = my_upgrade
	%CostLabel.text = str(my_cost)
	if GameState.upgrades.has(my_upgrade):
		my_level = GameState.upgrades.get(my_upgrade)
