extends Node2D

var one
var two
var thr
var ans = 0
var rng = RandomNumberGenerator.new()
var is_ready

func _ready():
	equation()
	$VBox/CAnswer/Guess.grab_focus()
	$Timer.start()

func _on_Timer_timeout():
	scene_handler.next_scene()

func equation():
	rng.randomize()
	one = rng.randi_range(1,20)
	two = rng.randi_range(1,20)
	thr = rng.randi_range(1,20)
	var m = rng.randi_range(1,4)
	var l = $VBox/CEquation/LEquation
	match m:
		1:
			ans = one + two + thr
			l.text = "%s + %s + %s" % [one, two, thr]
		2:
			ans = one - two + thr
			l.text = "%s - %s + %s" % [one, two, thr]
		3:
			ans = one * two - thr
			l.text = "%s * %s - %s" % [one, two, thr]
		4:
			ans = (one - two) * thr
			l.text = "(%s - %s) * %s" % [one, two, thr]

func _on_Guess_text_entered(new_text):
	if new_text == String(ans):
		win()
	$VBox/CAnswer/Guess.clear()

func win():
	stats.add_stats("xp", 250)
	stats.add_stats("g", 500)
	chat.won_event("math")
	contract_handler.event("quick maths")
	scene_handler.next_scene()
