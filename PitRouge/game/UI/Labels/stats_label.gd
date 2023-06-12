extends Labels
class_name Stats_label

@export_enum("G", "XP", "Str", "MS") \
var type: String

func _ready():
	get_tree().call_group("player", "call_stats_label")

func update(a : person):
	match type:
		"G":
			text = "Gold: [color=" + COLOR_GOLD + "]" + str(a.stats.gold) + "g[/color]" 
		"XP":
			text = "XP: [color=" + COLOR_AQUA + "]" + str(a.stats.xp) + "[/color]" 
		"Str":
			text = "Streak: [color=" + COLOR_GREEN + "]" + str(a.run_stats["streak"]) + "[/color]" 
		"MS":
			text = "Mystic Shards: [color=" + COLOR_YELLOW + "]" + str(a.mystic_shards) + "[/color]" 
