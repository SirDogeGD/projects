extends Node
class_name level

var xp_per_level := [15, 30, 50, 75, 125, 300, 600, 800, 900, 1000, 1200, 1500]
var mult_per_pres := [1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.75, 2, 2.5, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 24, 28, 32, 36, 40, 45, 50, 75, 100, 101, 101, 101, 101, 101, 200, 300, 400, 500, 750, 1000, 1250, 1500, 1750, 2000, 3000, 5000, 10000, 50000, 100000]
var C := Constants.new()
var level_colors := [C.COLOR_DARK_GREY, C.COLOR_DARK_BLUE, C.COLOR_DARK_AQUA, C.COLOR_DARK_GREEN, C.COLOR_GREEN, C.COLOR_YELLOW, C.COLOR_GOLD, C.COLOR_RED, C.COLOR_DARK_RED, C.COLOR_PURPLE, C.COLOR_PINK, C.COLOR_WHITE, C.COLOR_AQUA]

func get_total_xp_needed(pers : person = null) -> int:
	var total : int
	var pres := pers.stats.prestige if pers != null else 0
	
	for n in xp_per_level:
		total += n * 10
	total *= mult_per_pres[pres]
	return total

func get_xp_of(lvl : int, pers : person = null) -> int:
	var amount : int
	
	for n in range(1, lvl):
		amount += xp_per_level[floor(n/10.0)]
	
	if pers != null:
		amount *= mult_per_pres[pers.stats.prestige]
	
	return amount

func get_level(pers : person) -> int:
	
	for n in range(1, 120):
		if get_xp_of(n, pers) > pers.XP:
			return n - 1
	
	return 1

func get_xp_to_next_level(pers : person) -> int:
#	print("current level: ", get_level(pers))
#	print("current xp of level: ", get_xp_of(get_level(pers), pers))
#	print("next xp of level: ", get_xp_of(get_level(pers) + 1, pers))
	return get_xp_of(get_level(pers) + 1, pers) - pers.XP

func get_lvl_text(lvl : int) -> String: #replace DARK GREY with color from Prestige later
	return "Level: " \
		+ "[color=" + C.COLOR_DARK_GREY + "][[/color]" \
		+ "[color=" + level_colors[floor(lvl/10.0)] + "]" + str(lvl) + "[/color]" \
		+ "[color=" + C.COLOR_DARK_GREY + "]][/color]"
