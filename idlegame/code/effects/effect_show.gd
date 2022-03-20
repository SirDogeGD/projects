extends Control

var ename
var level

func get_name():
	return self.ename

func get_level():
	return self.level

func set(n, l):
	self.ename = n
	self.level = l
	
	var regen = load("res://icons/effect/regen.png")
	var strength = load("res://icons/effect/str.png")
	var weak = load("res://icons/effect/weak.png")
	var res = load("res://icons/effect/res.png")
	match ename:
		"r":
			$Icon.texture = regen
		"str":
			$Icon.texture = strength
		"weakness":
			$Icon.texture = weak
		"res":
			$Icon.texture = res
	
	$LLevel.set_text(str(l))
