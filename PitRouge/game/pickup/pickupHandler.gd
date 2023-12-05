extends Node

class_name pickupHandler

func pickup(what : pickup, who : person):
	var r = rewards_data.new()
	match what.type:
		what.typeEnum.GOLD_INGOT:
			r.gold = 5
		what.typeEnum.XP_BLOB:
			r.xp = 5
	
	who.be_rewarded(r)
