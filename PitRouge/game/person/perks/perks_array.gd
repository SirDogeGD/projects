extends Node
class_name perks_array

var store := []
var guy : person

func add(id : String):
	store.append(id)
	
	#Check if perk requires a radius
	if PINFO.area_perks(id) > 0:
		guy.add_radius(id, PINFO.area_perks(id))

func erase(id : String):
	if store.count(id) == 1:
		remove_all(id)
	else:
		store.erase(id)

#remove all of one perk
func remove_all(id : String):
	var newArray := []
	for elem in store:
		if elem != id:
			newArray.append(id)
	store = newArray.duplicate()
	
		#Check if perk requires a radius
	if PINFO.area_perks(id) > 0:
		guy.remove_radius(id)

func count(id : String) -> int:
	return store.count(id)

func clear():
	var u_perks := []
	for id in store:
		if not u_perks.has(id):
			u_perks.append(id)
	for id in u_perks:
		remove_all(id)
