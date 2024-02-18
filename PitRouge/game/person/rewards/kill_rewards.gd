extends Node
class_name kill_rewards
#handles kill rewards

var a : person
var b : person
var BASE_GOLD := 10
var BASE_XP := 5

#get kill perks
func pkill(what : String):
	return PERKS.calc(what, a, b)

#get non kill perks
func perks(what : String):
	return PERKS.get_value(a, what)

#main function
func kill(killer : person, died : person) -> rewards_data:
	a = killer
	b = died
	
	var r = rewards_data.new()
	r.gold = kill_gold()
	r.xp = kill_xp()
	
	return r

func kill_gold():
	#BASE
	var base : float = BASE_GOLD
	base += pkill("base_gold")
	base += a.mega_stats.g_on_kill
	#MULT
	var mult := 1.0
	mult *= 1 + pkill("mult_gold")
	mult *= 1 + a.mega_stats.gboost
	
	return base * mult

func kill_xp():
	#BASE
	var base : float = BASE_XP
	base += pkill("base_xp")
	base += a.mega_stats.xp_on_kill
	#Streak
	var streak = a.run_stats["streak"]
	var streakBoost := 0.0
	if streak in range(3,4): #streak boost based on streak
		streakBoost = 3
	elif streak in range(5,19):
		streakBoost = 5
	elif streak >= 20:
		streakBoost = min(3 * int(streak/10), 30)
	base += streakBoost * 1 + perks("SWEATY") / 100
	#MULT
	var mult := 1.0
	mult *= pkill("mult_xp")
	mult *= 1 + a.mega_stats.xpboost
	
	return base * mult

