extends Node2D

func _ready():
	update_labels()

func _on_BBack_pressed():
	get_tree().change_scene("res://code/places/camp.tscn")

func req_text():
	return str("Required: ", stats.xp, "/", req_xp(), "xp")

func req_xp():
	return 50000 + (stats.prestige * 10000)

func _on_BPrestige_pressed():
	if stats.xp >= req_xp():
		stats.xp = 0
		stats.gold = 0
		stats.add_stats("r", (10 + stats.prestige))
		stats.prestige += 1
		update_labels()

func update_labels():
	$VBoxContainer/CenterContainer2/VBoxContainer/LPres.set_text(str("Prestige: ", stats.prestige))
	$VBoxContainer/CenterContainer2/VBoxContainer/LReq.set_text(req_text())


func _on_BShop_pressed():
	if stats.prestige >= 1:
		get_tree().change_scene("res://code/prestige/prestigeShop.tscn")
