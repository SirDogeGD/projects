extends CanvasLayer

func update_inv(i : inventory):
	$inventory.update_slots(i)

func update_dash(max : int, left : int):
	$dash_ui.update_slots(max, left)
