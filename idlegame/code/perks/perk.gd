extends Resource
class_name perk

var pname : String setget set_name, get_name
var desc : String setget set_desc, get_desc
var nums : Dictionary
var unlock : String = "DEFAULT"

func set_name(n:String):
	pname = n

func get_name():
	return pname

func set_desc(d:String):
	desc = d

func get_desc():
	return desc % nums[0]

func set_nums(n:Dictionary):
	nums = n

func set_unlock(u:String):
	if u != null:
		unlock = u

func get_unlock():
	if unlock == "DEFAULT" or unlock in you.perks:
		return true
	return false
