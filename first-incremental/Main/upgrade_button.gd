extends Button
class_name upgradebutton

@export var my_upgrade : String#:
	#set(t):
		#%TextLabel.text = t
@export var my_cost : int#:
	#set(c):
		#%CostLabel.text = str(c)

func _on_pressed() -> void:
	GameState.buy_upgrade(my_upgrade, my_cost)

func _on_ready() -> void:
	%TextLabel.text = my_upgrade
	%CostLabel.text = str(my_cost)
