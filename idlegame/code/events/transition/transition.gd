extends Node2D

signal transitioned

func _ready():
	$AnimationPlayer.play("fade_away")

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("transitioned")
	get_tree().paused = false
	self.queue_free()

func set_text(t):
	$Text.text = t
