extends Node
class_name bountyHandler

var max_bounty := 5000

func bump(a : person, b : person):
	if a.run_stats.bounty != max_bounty:
		var chance : float = max(0,(a.run_stats.streak - 5) / 100)
		if randf() <= chance:
			a.run_stats.bounty = min(max_bounty, a.run_stats.bounty + 100)
