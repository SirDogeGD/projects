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
	%player.connect("effects_changed",Callable(UI,"update_effects"))
	out_signals()

func out_signals():
	%player.all_signals()

func spawn_enemy():
	var enemyScene = preload("res://game/person/enemy/enemy.tscn").instantiate()
	add_child(enemyScene)
