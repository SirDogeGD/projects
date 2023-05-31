extends Node
class_name rewards

var a : person
var b : person
var BASE_GOLD := 10
var BASE_XP := 5
var kill_rewards := {
	"G" : 0.0,
	"X" : 0.0
}

func kill(killer : person, died : person):
	a = killer
	b = died
	
	kill_rewards["G"] = gold()
	
	return kill_rewards

func gold():
	#BASE
	var base : float = BASE_GOLD
	base += PERKS.calc("BASE_GOLD", a, b)
	#MULT
	var mult := 1.0
	mult *= PERKS.calc("MULT_GOLD", a, b)
	
	return base * mult

func xp():
	#BASE
	var base : float = BASE_XP
	base += PERKS.calc("BASE_XP", a, b)
	#Streak
	var streak = a.run_stats["streak"]
	var streakBoost := 0.0
	if streak in range(3,4):
		streakBoost = 3
	elif streak in range(5,19):
		streakBoost = 5
	elif streak >= 20:
		streakBoost = min(3 * int(streak/10), 30)
	base += streakBoost * 1 + PERKS.get_value(a, "SWEATY") / 100
	#MULT
	var mult := 1.0
	mult *= PERKS.calc("MULT_XP", a, b)
	
	return base * mult
