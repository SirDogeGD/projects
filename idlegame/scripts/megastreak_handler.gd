extends Node

func get_all(who, s):
	var mega = who.get_mega()
	
	if(check_activated(mega, s)):
		chat.mega(mega)
		who.mactive = true
	
	var arr = []
	arr.append(get_true(mega, s))
	arr.append(get_dmg(mega, s))
	arr.append(get_gboost(mega, s))
	arr.append(get_xpboost(mega, s))
	arr.append(get_dmgboost(mega, s))
	return(arr)

func get_true(name, s):
	match name:
		"od":
			if s >= 10:
				var dmg : float = ((float(s) - 10) / 5) / 10
				return dmg
		_:
			return 0
	return 0

func get_dmg(name, s):
	match name:
		"b":
			if s >= 20:
				var dmg : float = ((float(s) - 10) / 5) / 10
				return dmg
		_:
			return 0
	return 0

func get_gboost(name, s):
	match name:
		"od":
			if s >= 10:
				return 0.5
		"b":
			if s>= 20:
				return 0.75
	return 0

func get_xpboost(name, s):
	match name:
		"od":
			if s >= 10:
				return 1
		"b":
			if s>= 20:
				return 0.5
	return 0

func get_dmgboost(name, s):
	match name:
		"b":
			return 0.25
		_:
			return 0

func check_activated(name, s):
	match name:
		"od":
			if s == 10:
				return true
		"b":
			if s == 20:
				return true

func on_death(who, s):
	if who.mactive:
		var mega = who.get_mega()
		match mega:
			"od":
				stats.add_stats("xp", 4000)
