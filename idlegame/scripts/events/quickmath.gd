extends Node2D

var one
var two
var thr
var ans = 0
var rng = RandomNumberGenerator.new()
var is_ready

func _ready():
	is_ready = false

func _process(delta):
	if is_ready == false:
		if Input.is_action_just_pressed("attack"):
			_on_BReady_pressed()

func _on_BReady_pressed():
	is_ready = true
	$VBox/CReady/BReady.queue_free()
	equation()
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
			l.set_text(String(one) + " + " + String(two) + " + " + String(thr))
		2:
			ans = one - two + thr
			l.set_text(String(one) + " - " + String(two) + " + " + String(thr))
		3:
			ans = one * two - thr
			l.set_text(String(one) + " * " + String(two) + " - " + String(thr))
		4:
			ans = (one - two) * thr
			l.set_text("(" + String(one) + " - " + String(two) + ") * " + String(thr))

func _on_Guess_text_entered(new_text):
	if new_text == String(ans):
		win()

func win():
	stats.add_stats("xp", 250)
	stats.add_stats("g", 500)
	scene_handler.next_scene()
