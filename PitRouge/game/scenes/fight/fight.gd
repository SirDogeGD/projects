extends Node2D

func _ready():
	var p = PREF.getp()
	if p:
		_on_player_ready(p)
	else:
		PREF.player_ready.connect(_on_player_ready, CONNECT_ONE_SHOT)

func _on_player_ready(player):
	PUI.new_choice()
