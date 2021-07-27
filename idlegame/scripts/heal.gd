extends "res://scripts/item.gd"

var hp
var shield
var effects = {}
var consumable = true

func get_hp():
	return hp

func set_hp(h):
	self.hp = h

func get_shield():
	return shield

func set_shield(s):
	self.shield = s

func use_on(who):
	who.heal(self.get_hp(), self.get_shield())
	if (consumable):
		who.consume_item()
