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
	var t = get_type(id)
	slots[t][id] -= 1
	#remove if empty
	if slots[t][id] == 0: 
		slots[t].erase(id)
		
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

func clear():
	for type in slots.keys():
		for id in slots[type].keys():
			slots[type].erase(id)
	emit_signal("perks_changed", slots)

func get_uniques(want := "ALL") -> Array[String]:
	var uniques : Array[String]
	for type in slots.keys():
		if want in ["ALL", type]: #get all or only get of one type
			#uniques += slots[type].keys()
			for id in slots[type].keys():
				uniques.append(id)
	return uniques

func get_maxed() -> Array:
	var maxed : Array
	for type in slots.keys():
		for id in slots[type].keys():
			if slots[type][id] == 3:
				maxed.append(id)
	return maxed

func count(id : String) -> int:
	for type in slots.keys():
		for p in slots[type].keys():
			if p == id:
				return slots[type][id]
	return 0

func slot_not_full(id : String) -> bool:
	var t = get_type(id)
	if slots[t].has(id):
		return true
	if slots[t].size() == get_max(t):
		return false
	return true
