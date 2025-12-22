extends CanvasLayer

func _ready():
	PREF.player_ready.connect(connect_signals)

func connect_signals(p : player):
	p.inv_changed.connect(Callable(UI,"update_inv"))
	p.dash_changed.connect(Callable(UI,"update_dash"))
	p.health_changed.connect(Callable(UI,"update_health"))
	%effects_ui.connected_person = p

func update_inv(i : inventory):
	%inventory.update_slots(i)

func update_dash(max_dash : int, left : int):
	%dash_ui.update_slots(max_dash, left)

func update_health(hp : hp_data):
	%HeartBar.update_health(hp)
