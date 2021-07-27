extends Node

var pname
var desc

func _ready():
	pass # Replace with function body.

func set_name(n):
	self.pname = n

func get_name():
	return self.pname

func set_desc(d):
	self.desc = d

func get_desc():
	return self.desc
