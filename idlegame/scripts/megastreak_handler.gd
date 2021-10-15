extends Node

func get_all(who, s):
	var mega = who.get_mega()
	return([get_true(mega, s), get_dmg(mega, s), get_gboost(mega, s), get_xpboost(mega, s)])

func get_true(name, s):
	match name:
		"od":
			if s >= 10:
				var dmg : float = ((float(s) - 10) / 5) / 10
				return dmg
		"b":
			return 0
	return 0

func get_dmg(name, s):
	match name:
		"od":
			return 0
		"b":
			if s >= 20:
				pass
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
