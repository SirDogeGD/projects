extends Node
class_name boosts

#run xp and gold gain through boosts

static func gold(value : float, a : person) -> float:
	
	value *= 1 + a.mega_stats.gboost
	
	return value

static func xp(value : float, a : person) -> float:
	
	value *= 1 + a.mega_stats.xpboost
	
	return value
