extends CanvasLayer

func update_inv(i : inventory):
	%inventory.update_slots(i)

func update_dash(max_dash : int, left : int):
	%dash_ui.update_slots(max_dash, left)

func update_health(hp : hp_data):
	%HeartBar.update_health(hp)

func update_effects(e : Dictionary):
	%effects_ui.update(e)
