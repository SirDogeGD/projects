extends Node2D

func _ready():
	in_signals()
	%Camera.following = %player

func _enter_tree():
	UI.show()

func in_signals():
	%player.connect("inv_changed",Callable(UI,"update_inv"))
	%player.connect("dash_changed",Callable(UI,"update_dash"))
	%player.connect("health_changed",Callable(UI,"update_health"))
	out_signals()

func out_signals():
	%player.emit_signal("inv_changed", %player.inv)
	%player.emit_signal("dash_changed", %player.dash_max, %player.dash_left)
	%player.hp_signal()

func spawn_enemy():
	var enemyScene = preload("res://game/person/enemy/enemy.tscn").instantiate()
	add_child(enemyScene)
