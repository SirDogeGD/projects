extends Node2D

signal transitioned

func _ready():
#	$AnimationPlayer.play("fade_away")
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("transitioned")
#	self.queue_free()

func set_text(t):
	$Text.text = t
