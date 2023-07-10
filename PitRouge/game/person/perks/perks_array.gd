extends Node
class_name perks_array

signal perks_changed(store : Array[String])

var store : Array[String]
var guy : person

func add(id : String):
	store.append(id)
	
	#Check if perk requires a new radius
	if PINFO.area_perks(id) > 0 and store.count(id) == 1:
		guy.radii.add_radius(id, PINFO.area_perks(id))
	#Check if perk requires a new timer
	if PINFO.timer_perks(id) > 0 and store.count(id) == 1:
		guy.timers.add_timer(id, PINFO.timer_perks(id))
	
	emit_signal("perks_changed", store)

#remove one of one perk
func erase(id : String):
	if store.count(id) == 1:
		remove_all(id)
	else:
		store.erase(id)
	emit_signal("perks_changed", store)

#remove all of one perk
func remove_all(id : String):
	var newArray : Array
	for elem in store:
		if elem != id:
			newArray.append(id)
	store = newArray.duplicate()
	emit_signal("perks_changed", store)
	
	#Check if perk requires a radius
	if PINFO.area_perks(id) > 0:
		guy.radii.remove_radius(id)
	#Check if perk requires a timer
	if PINFO.timer_perks(id) > 0:
		guy.timers.remove_timer(id)

func count(id : String) -> int:
	return store.count(id)

func clear():
	for id in get_uniques():
		remove_all(id)

func get_uniques() -> Array[String]:
	var u_perks : Array[String]
	for id in store:
		if not u_perks.has(id):
			u_perks.append(id)
	return u_perks

func get_maxed() -> Array[String]:
	var maxed : Array[String]
	for p in get_uniques():
		if store.count(p) == 3:
			maxed.append(p)
	return maxed
