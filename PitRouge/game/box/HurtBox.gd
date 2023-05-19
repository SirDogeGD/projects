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
	var defender : person = owner
	defender.get_hit(attacker, DMG.calc(attacker, defender))
