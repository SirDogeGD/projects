extends Node2D

func _ready():
	in_signals()
	
func _process(delta):
	pass

func in_signals():
	$player.connect("inv_changed",Callable(UI,"update_inv"))
	$player.connect("dash_changed",Callable(UI,"update_dash"))
	out_signals()

func out_signals():
	$player.emit_signal("inv_changed", $player.inv)
	$player.emit_signal("dash_changed", $player.dash_max, $player.dash_left)
