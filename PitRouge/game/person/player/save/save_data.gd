extends Resource
class_name save_data

#will store stats per prestige
var prestige := 0
var gold := [0.0]
var xp := [0.0]
var kills := [0]
var deaths := [0]
var renown := [0]

func reset():
	prestige = 0
	gold.clear()
	xp.clear()
	kills.clear()
	deaths.clear()
	renown.clear()

func random():
	reset()
	randomize()
	var power = randf()
	if power < 0.8:
		weak()
	elif power < 0.95:
		mid()
	else:
		strong()

func weak():
	prestige = 0
	gold[prestige] = 4000

func mid():
	prestige = 10
	gold[prestige] = 20000

func strong():
	prestige = 20
	gold[prestige] = 100000
