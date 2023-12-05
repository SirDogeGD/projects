extends RichTextLabel
class_name Stats_label

@export_enum("G", "XP", "Str", "MS") \
var type: String
var C := Constants.new()

func _ready():
	get_tree().call_group("player", "call_info")

func update(a : person):
	match type:
		"G":
			var gold = a.stats.gold + a.run_stats["gold"]
			text = "Gold: [color=" + C.COLOR_GOLD + "]" + str(gold) + "g[/color]" 
		"XP":
			var xp = a.stats.xp + a.run_stats["xp"] 
			text = "XP: [color=" + C.COLOR_AQUA + "]" + str(xp) + "[/color]" 
		"Str":
			text = "Streak: [color=" + C.COLOR_GREEN + "]" + str(a.run_stats["streak"]) + "[/color]" 
		"MS":
			text = "Mystic Shards: [color=" + C.COLOR_YELLOW + "]" + str(a.mystic_shards) + "[/color]"
