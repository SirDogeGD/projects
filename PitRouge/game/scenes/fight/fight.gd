extends Node2D

@onready var p : player = %player

func _ready():
	in_signals()
	%Camera.following = p

func _enter_tree():
	UI.show()

func in_signals():
	p.inv_changed.connect(Callable(UI,"update_inv"))
	p.dash_changed.connect(Callable(UI,"update_dash"))
	p.health_changed.connect(Callable(UI,"update_health"))
	p.effect_node.connect("effects_changed",Callable(UI,"update_effects"))
	out_signals()

func out_signals():
	p.all_signals()

func spawn_enemy():
	var enemyScene = preload("res://game/person/enemy/enemy.tscn").instantiate()
	add_child(enemyScene)
