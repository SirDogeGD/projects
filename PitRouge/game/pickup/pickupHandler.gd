extends Node

class_name pickupHandler

func pickup(what : pickup, who : person):
	var val := 0.0
	match what.type:
		what.typeEnum.GOLD_INGOT:
			val = 5
			val += PERKS.get_a_num(who, "PEBBLE")
			PERKS.on_ingot_pickup(who)
			who.run_stats.gold += val
		what.typeEnum.XP_BLOB:
			val = 5
			who.run_stats.xp += val
