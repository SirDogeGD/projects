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
			text = "Gold: [color=" + C.COLOR_GOLD + "]" + str(a.stats.gold) + "g[/color]" 
		"XP":
			text = "XP: [color=" + C.COLOR_AQUA + "]" + str(a.stats.xp) + "[/color]" 
		"Str":
			text = "Streak: [color=" + C.COLOR_GREEN + "]" + str(a.run_stats["streak"]) + "[/color]" 
		"MS":
			text = "Mystic Shards: [color=" + C.COLOR_YELLOW + "]" + str(a.mystic_shards) + "[/color]"
 
