extends Node2D

signal jumpdown

@onready var p : player = SAVE.pers

func _ready():
	call_deferred("add_child", p)
#	add_child(p)
	p.position = %Spawnpos.position

func _on_hole_entered(body):
	print("body that entered: ", body.name)
	if body == p:
		print("player touched hole")
		print(%Hole)
		print("---------------------")
		%Hole.set_process(false)
		%Hole.queue_free()
		jumpdown.emit()
