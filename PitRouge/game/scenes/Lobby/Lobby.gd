extends Node2D

signal jumpdown

@onready var p : player = SAVE.pers
@onready var holeScene := preload("res://game/scenes/Lobby/hole.tscn")
@onready var h : hole = holeScene.instantiate()

func _ready():
#	call_deferred("add_child", p)
	if not p in get_children():
		add_child(p)
	#Add Hole
	add_child(h)
	h.signal_entered.connect(_on_hole_entered)
	
	p.position = %Spawnpos.position
	print("lobby ready")

func _on_hole_entered():
	remove_child(p)
	print("JAMPU")
	jumpdown.emit()
