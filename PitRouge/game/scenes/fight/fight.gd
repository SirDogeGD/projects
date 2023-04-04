extends Node2D

func _ready():
	in_signals()
	
func _process(delta):
	pass

func in_signals():
	$player.connect("inv_changed",Callable($"/root/UI","update_inv"))
	out_signals()

func out_signals():
	$player.emit_signal("inv_changed", $player.inv)
