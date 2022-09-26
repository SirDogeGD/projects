extends CenterContainer

func _ready():
#	run stats ------------------
	$HSplitContainer/VBox/LXP.text = "XP: " + str(scene_handler.run_xp)
	$HSplitContainer/VBox/LG.text = "Gold: " + str(scene_handler.run_g)
	$HSplitContainer/VBox/LDMG.text = "Dmg: " + str(scene_handler.run_dmg)
	bounty_text()
#	mega stats ------------------
	mega_side(you.mega)

#mega stats
func mega_side(m):
	var text = megastreak_handler.make_stats()
	for e in text:
		var l = Label.new()
		l.text = str(e)
		$HSplitContainer/VBoxMega.add_child(l)

func bounty_text():
	if you.bounty > 0:
		var l = Label.new()
		l.text = "Bounty: %s" % you.bounty
		$HSplitContainer/VBox.add_child(l)
