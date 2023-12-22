extends Node
class_name level

var xp_per_level := [15, 30, 50, 75, 125, 300, 600, 800, 900, 1000, 1200, 1500]
var mult_per_pres := [1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.75, 2, 2.5, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 24, 28, 32, 36, 40, 45, 50, 75, 100, 101, 101, 101, 101, 101, 200, 300, 400, 500, 750, 1000, 1250, 1500, 1750, 2000, 3000, 5000, 10000, 50000, 100000]

func get_total_xp_needed(pers : person) -> int:
	var total : int
	for n in xp_per_level:
		total += n * 10
	print("mult is: ", mult_per_pres[1])
	total *= mult_per_pres[pers.stats.prestige]
	return total

func get_xp_of(lvl : int, pers : person = null) -> int:
	var amount : int
	var tens := 0
	
	for n in lvl:
		if n + 1 % 10 == 0: #go up every 10 levels
			tens += 1
		amount += xp_per_level[tens]
	
	if pers != null:
		amount *= mult_per_pres[pers.stats.prestige]
	
	return amount
