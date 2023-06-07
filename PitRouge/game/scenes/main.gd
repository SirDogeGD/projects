extends Node

func _ready():
	var fightscene = preload("res://game/scenes/fight/fight.tscn")
	add_child(fightscene.instantiate())
