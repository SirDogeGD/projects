extends Node
class_name perk_slots

signal perks_changed(slots : Dictionary)

var guy : person
var slots := {
	"HEAL" : {}, #healing (replaces golden apples)
	"DEF" : {}, #on take dmg , defence and stuff like pero and prick
	"MOVE" : {}, #speed and dashes
	"SWORD" : {}, #on hit, on kill
	"BOW" : {}, #same but with bow
	"GXP" : {} #anything resource related, gold and xp and other
}

func add(id : String):
	var type := get_type(id)
	if slots[type].has(id): #upgrade perk
		slots[type][id] += 1
	#new perk
	else: 
		slots[type][id] = 1
		
		#Check if perk requires a new radius
		if PINFO.area_perks(id) > 0:
			guy.radii.add_radius(id)
		#Check if perk requires a new timer
		if PINFO.timer_perks(id) > 0:
			guy.timers.add_timer(id)
	
	emit_signal("perks_changed", slots)

func remove(id : String):
	slots[get_type(id)][id] -= 1
	#remove if empty
	if slots[get_type(id)][id] == 0: 
		slots[get_type(id)].erase(id)
		
		#Check if perk required a radius
		if PINFO.area_perks(id) > 0:
			guy.radii.remove_radius(id)
		#Check if perk required a timer
		if PINFO.timer_perks(id) > 0:
			guy.timers.remove_timer(id)
	
	emit_signal("perks_changed", slots)

func get_max(type : String) -> int:
	match type:
		"HEAL":
			return 1
		"DEF":
			return 3
		"MOVE":
			return 1
		"SWORD":
			return 3
		"BOW":
			return 3
		"GXP":
			return 2
	return 0

func get_type(id : String) -> String:
	return PINFO.perkinfo(id, guy).type

func can_add(id : String) -> bool:
	var type = get_type(id)
	if slots[type] == get_max(type):
		return false
	return true

func clear():
	for type in slots.keys():
		for id in slots[type].keys():
			slots[type].erase(id)
	emit_signal("perks_changed", slots)

func get_uniques() -> Array[String]:
	var uniques : Array[String]
	for type in slots.keys():
		for id in slots[type].keys():
			uniques.append(id)
	return uniques

func get_maxed() -> Array[String]:
	var maxed : Array[String]
	for type in slots.keys():
		for id in slots[type].keys():
			if slots[type][id] == 3:
				maxed.append(id)
	return maxed

func count(id : String) -> int:
	return slots[get_type(id)][id]

func slot_not_full(id) -> bool:
	if slots[get_type(id)].has(id):
		return true
	if slots[get_type(id)].size() == get_max(get_type(id)):
		return false
	return true
