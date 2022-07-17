extends Area2D

func _ready():
	position.x = 950
	position.y = 520

func _on_finish_body_entered(body):
	Levels.nextLvl()