extends CenterContainer

func _ready():
#	run stats ------------------
	$HSplitContainer/VBox/LXP.text = "XP: " + str(scene_handler.run_xp)
	$HSplitContainer/VBox/LG.text = "Gold: " + str(scene_handler.run_g)
	$HSplitContainer/VBox/LDMG.text = "Dmg: " + str(scene_handler.run_dmg)
#	mega stats ------------------
	mega_side(you.get_mega())

#mega stats
func mega_side(m):
	var text = megastreak_handler.make_stats(you)
	for e in text:
		var l = Label.new()
		l.text = str(e)
		$HSplitContainer/VBoxMega.add_child(l)
