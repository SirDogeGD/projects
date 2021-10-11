extends "res://scripts/items/item.gd"

var hp
var shield
var effects = []
var consumable = true

func get_hp():
	return hp

func set_hp(h):
	self.hp = h

func get_shield():
	return shield

func set_shield(s):
	self.shield = s

func add_effects(e):
	self.effects += e

func use_on(who):
	who.heal(self.get_hp(), self.get_shield())
	for e in effects:
		effect_handler.add_effect(e, who)
	if (consumable):
		who.consume_item()
