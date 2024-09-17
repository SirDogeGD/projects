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
	var damage_done := DMG.calc(attacker, defender)
	defender.get_hit(attacker, damage_done)
	attacker.on_hit(defender, damage_done)
