extends Node2D

var has_hole := false

@onready var holeScene := preload("res://game/scenes/Lobby/hole.tscn")
@onready var h : hole = holeScene.instantiate()

func _ready():
	#Add Hole
	if not has_hole:
		add_child(h)
		has_hole = true
		h.signal_entered.connect(_on_hole_entered)

func _on_hole_entered():
	SIGNAL.speak("JUMP")
	SCENE.switch_to("fight")
	PREF.getp().invulnerable = false

func _enter_tree():
	UI.show()
