extends Node

class_name pickupHandler

func pickup(what : pickup, who : person):
	match what.type:
		what.typeEnum.GOLD_INGOT:
			print("gold picked up :)))")
		what.typeEnum.XP_BLOB:
			print("xp picked up :))))")
