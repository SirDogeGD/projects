extends Node

var ename
var level
var duration
var done = false

func set_name(n):
	self.ename = n

func get_name():
	return self.ename

func set_level(l):
	self.level = l

func get_level():
	return self.level

func set_duration(d):
	self.duration = d

func get_duration():
	return duration

func tick():
	duration = duration - 1
	if(duration == 0):
		done = true
