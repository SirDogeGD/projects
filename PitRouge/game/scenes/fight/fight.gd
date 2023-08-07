extends Node2D

@onready var p : player = SAVE.pers

func _ready():
	call_deferred("add_child", p)
#	add_child(p)
	%Camera.following = p
	p.position.x = 0
	in_signals()
	PUI.new_choice()

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
