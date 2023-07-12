extends Node
class_name perks_array

signal perks_changed(all : Array[String])

var guy : person
var all : Array[String]
var slots := perk_slots.new()

func _ready():
	slots.guy = guy

func add(id : String):
	all.append(id)
	
	#Check if perk requires a new radius
	if PINFO.area_perks(id) > 0 and all.count(id) == 1:
		guy.radii.add_radius(id, PINFO.area_perks(id))
	#Check if perk requires a new timer
	if PINFO.timer_perks(id) > 0 and all.count(id) == 1:
		guy.timers.add_timer(id, PINFO.timer_perks(id))
	
	slots.add(id)
	emit_signal("perks_changed", all)

#remove one of one perk
func erase(id : String):
	if all.count(id) == 1:
		remove_all(id)
	else:
		all.erase(id)
	emit_signal("perks_changed", all)

#remove all of one perk
func remove_all(id : String):
	var newArray : Array
	for elem in all:
		if elem != id:
			newArray.append(id)
	all = newArray.duplicate()
	slots.remove(id)
	emit_signal("perks_changed", all)
	
	#Check if perk requires a radius
	if PINFO.area_perks(id) > 0:
		guy.radii.remove_radius(id)
	#Check if perk requires a timer
	if PINFO.timer_perks(id) > 0:
		guy.timers.remove_timer(id)

func clear():
	for id in get_uniques():
		remove_all(id)

func count(id : String) -> int:
	return all.count(id)

func get_uniques() -> Array[String]:
	var u_perks : Array[String]
	for id in all:
		if not u_perks.has(id):
			u_perks.append(id)
	return u_perks

func get_maxed() -> Array[String]:
	var maxed : Array[String]
	for p in get_uniques():
		if all.count(p) == 3:
			maxed.append(p)
	return maxed
