extends Node

var count = 0
var maxcount

#type variabel
#if type = p, point is a perk id
#if type = b, point is a shop perk id
#if type = e, point is an event name
var type = ""
var point

func set_count(c):
	self.maxcount = c

func get_count():
	return self.count

func get_maxcount():
	return self.maxcount

func count():
	count += 1
	if count == maxcount:
		contract_handler.complete(self)

func set_type(t):
	self.type = t

func get_type():
	return self.type

func set_point(p):
	self.point = p

func get_point():
	return self.point
