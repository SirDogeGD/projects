extends Node
class_name perks_array

var store := []
var guy : person

func add(id : String):
	store.append(id)
	
	#Check if perk requires a radius
	var radius = PINFO.area_perks(id)
	if radius > 0:
		guy.add_radius(id, radius)

func remove(id : String):
	var newArray := []
	for elem in store:
		if elem != id:
			newArray.append(id)
	store = newArray.duplicate()

func count(id : String) -> int:
	return store.count(id)

func clear():
	store.clear()
