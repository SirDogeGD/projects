@icon("HurtBox.svg")
class_name HurtBox
extends Area2D

func _init():
	monitorable = false
	collision_mask = 2

func _ready(): 
	connect("area_entered",Callable(self,"_on_area_entered"))

func _on_area_entered(hitbox: HitBox) -> void:
	var attacker : person = hitbox.owner.owner
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
	if owner.has_method("get_hit"):
		owner.get_hit(attacker)
