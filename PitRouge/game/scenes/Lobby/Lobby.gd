extends Node2D

signal jumpdown

@onready var p : player = SAVE.pers
@onready var holeScene := preload("res://game/scenes/Lobby/hole.tscn")
@onready var h : hole = holeScene.instantiate()

func _ready():
#	call_deferred("add_child", p)
	if not p in get_children():
		add_child(p)
	in_signals()
	#Add Hole
	add_child(h)
	h.signal_entered.connect(_on_hole_entered)
	
	p.position = %Spawnpos.position
#	print("lobby ready")

func _on_hole_entered():
	remove_child(p)
	jumpdown.emit()

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

