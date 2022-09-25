extends Node

func bounty_up():
	if you.bounty < you.bounty_max:
		if scene_handler.rng.randi_range(1, 20) == 1:
			var bump = 100
			chat.bounty_bump(bump)
			you.set_bounty(you.bounty + bump)
