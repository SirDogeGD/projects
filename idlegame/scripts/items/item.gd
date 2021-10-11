extends Node

var item_name
var stacksize = 1
var amount = 1
var keep_on_death = true
var damage = 0
var takes_turn = true

func get_name():
	return item_name

func set_name(n):
	self.item_name = n

func get_ssize():
	return stacksize

func set_ssize(s):
	self.stacksize = s

func get_damage():
	return damage

func set_damage(dmg):
	self.damage = dmg

func get_on_death():
	return keep_on_death

func set_on_death(f):
	self.keep_on_death = f

func is_insta():
	self.takes_turn = false
