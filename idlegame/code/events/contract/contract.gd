extends Node

var type = ""
var count

#type variabel
#if type = p, point is a perk id
#if type = b, point is a shop perk id
#if type = e, point is an event name
var point

func set_count(c):
	self.count = c

func get_count():
	return self.count

func count():
	count -= 1
	if count == 0:
		contract_handler.complete(self)

func set_type(t):
	self.type = t

func get_type():
	return self.type

func set_point(p):
	self.point = p

func get_point():
	return self.point
