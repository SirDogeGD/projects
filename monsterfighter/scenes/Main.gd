extends Node2D

var Round = 0
var hp = Stats.hp * 10

var monFile = load("res://Monster.gd")
var mon

func _ready():
	randomize()
	Stats.load_game()
	next_round()
	hp = Stats.hp * 10
	$HeroHP.max_value = Stats.hp * 10
	$HeroHP.value = $HeroHP.max_value
	update_stats()
	$LootContainer.visible = false
	$AtkButton.visible = true

func next_round():
	Stats.save_Stats()
	Round = Round + 1
	make_monster()
	$MonHP.max_value = mon.get_hp()
	$MonHP.value = mon.get_hp()
	update_stats()

func make_monster():
	mon = monFile.new()
	mon.set_hp(Round * (randi()%20+1))
	mon.set_strength(round(Round * rand_range(0, 2)))

func update_stats():
	$HeroHP.max_value = Stats.hp * 10
	$HeroHP.value = hp
	$HeroHP/HPLabel.text = str($HeroHP.value)
	$MonHP.value = mon.get_hp()
	$MonHP/HPLabel.text = str(mon.get_hp())
	$StrLabel.text = "Strength: " + str(Stats.strength)
	$DefLabel.text = "Defence: " + str(Stats.def)
	$RoundLabel.text = ("Round: " + str(Round))

func dmg(w):
	if(w == 1):
		var dmg = round(rand_range(0, 2)) * Stats.strength
		print("mon dmg: " + str(dmg))
		mon.set_hp(mon.get_hp() - dmg)
		if(mon.get_hp() <= 0):
			$LootContainer.visible = true
			$AtkButton.visible = false
	if(w == 2):
		var dmg = round((rand_range(0, 2)) * mon.get_strength()) - Stats.def
		print("hero dmg: " + str(dmg))
		if(dmg > 0):
			hp = hp - dmg
			if(hp <= 0):
				Round = 0
				Stats.reset()
				_ready()

func _on_AtkButton_pressed():
	dmg(1)
	dmg(2)
	update_stats()

func _on_ButtonH_pressed():
	give_loot("h")


func _on_ButtonD_pressed():
	give_loot("d")


func _on_ButtonS_pressed():
	give_loot("s")

func give_loot(w):
	if(w == "h"):
		Stats.hp = Stats.hp + 1
	if(w == "d"):
		Stats.def = Stats.def + 1
	if(w == "s"):
		Stats.strength = Stats.strength + 1
	hp = hp + Stats.hp * 3
	var drop = randi()%3+1
	if(drop == 1):
		hp = Stats.hp * 10
	if(drop == 2):
		Stats.strength = Stats.strength + 1
	if(drop == 3):
		Stats.def = Stats.def + 1
	$LootContainer.visible = false
	$AtkButton.visible = true
	next_round()
