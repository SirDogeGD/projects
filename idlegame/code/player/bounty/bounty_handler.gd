extends Node

func bounty_up():
	if 8 in stats.pUpgrades:
		if you.bounty < you.bounty_max:
			if scene_handler.rng.randi_range(1, 20) == 1:
				var bump = 100
				chat.bounty_bump(bump)
				you.bounty += bump
