extends Resource
class_name perk

var pname : String : get = get_name, set = set_name
var desc : String : get = get_desc, set = set_desc
var nums : Array
var unlock : String = "DEFAULT"

func set_name(n:String):
	pname = n

func get_name():
	return pname

func set_desc(d:String):
	desc = d

func get_desc():
	var string_array : PackedStringArray
	for n in nums[0]:
		string_array.append(str(n))
	var desc_with_nums = desc % string_array
	return(desc_with_nums)

func set_nums(n:Array):
	nums = n

func set_unlock(u:String):
	if u != null:
		unlock = u

func get_unlock():
	if unlock == "DEFAULT" or unlock in you.perks:
		return true
	return false
