extends Node2D

@onready var p : player = SAVE.pers

func _ready():
#	call_deferred("add_child", p)
	add_child(p)
	%Camera.following = p
	PUI.new_choice()

func spawn_enemy():
	var enemyScene = preload("res://game/person/enemy/enemy.tscn").instantiate()
	add_child(enemyScene)
