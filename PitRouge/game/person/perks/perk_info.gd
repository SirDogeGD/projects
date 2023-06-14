extends Node

var pers : person
var perkid : String
var C := Constants.new()

func make(nam: String, desc: String, nums: Array[Array], type: String) -> perk_data:
	var data := perk_data.new()
	data.pname = nam
	data.desc = repl_desc(desc) % nums[pers.perks.count(perkid)]
	data.nums = nums
	data.type = type
	return data

func perkinfo(id : String, a : person) -> perk_data:
	pers = a
	perkid = id
	
	match id:
		0, "BARB":
			return make("Barbarian", "Your weapon deals +%s base dmg. Lose the ability to block",
				[[0.5],[0.9],[1.3],[1.7]],"DEFAULT")
		1, "SHARP":
			return make("Sharp", "Deal +%s%% melee damage",
				[[8],[16],[24],[32]],"DEFAULT")
		2, "PUN":
			return make("Punisher", "Deal +%s%% damage vs. players below 50%% HP",
				[[9],[18],[27],[36]],"DEFAULT")
		3, "K_BUST":
			return make("King Buster", "Deal +%s%% damage vs. players above 50%% HP",
				[[10],[20],[30],[40]],"DEFAULT")
		4, "PF":
			return make("Pain Focus", "Deal +%s%% damage per hp❤ you're missing",
				[[3],[4],[5],[6]],"DEFAULT")
		5, "GAB":
			return make("Gold and Boosted", "Deal +%s%% damage per shield heart you have",
				[[3],[4],[5],[6]],"DEFAULT")
		6, "DIA_BOOT":
			return make("Diamond boots", "Take %s%% less dmg",
				[[8],[16],[24],[32]],"DEFAULT")
		7, "DIA_CHEST":
			return make("Diamond Chestplate", "Take %s%% less dmg",
				[[9],[18],[27],[36]],"DEFAULT")
		8, "DIA_SWORD":
			return make("Diamond Sword", "Your weapon deals +%s base dmg",
				[[0.4],[0.8],[1.2],[1.6]],"DEFAULT")
		9, "BERS":
			return make("Berserker", "%s%% crit chance",
				[[12],[20],[28],[36]],"DEFAULT")
		10, "GUTS":
			return make("Guts", "Heal %s hp on kill",
				[[1.5],[2.5],[3.5],[5]],"DEFAULT")
		11, "C_DMG":
			return make("Combo: Damage", "Every fourth strike deals +%s%% damage",
				[[50],[75],[100],[150]],"DEFAULT")
		12, "C_SHIELD":
			return make("Combo: Shield", "Every fourth strike gives %s shield hp",
				[[1],[1.5],[2],[3]],"DEFAULT")
		13, "C_JAN":
			return make("Counter-Janitor", "Gain %s Resistance (%s sec) on kill",
				[[4, 4],[5, 4.5],[6, 5],[7, 5]],"DEFAULT")
		14, "C_CRUSH":
			return make("Combo: Crush", "Every fourth strike apply %s Weakness (%s sec)",
				[[2, 2],[3, 2.5],[4, 3],[5, 3.5]],"DEFAULT")
		15, "LS":
			return make("Lifesteal", "Heal for %s%% of damage dealt",
				[[4],[8],[12],[16]],"DEFAULT")
		16, "FSTRIKE":
			return make("First Strike", "Deal +%s%% dmg against enemies above 95% hp",
				[[75],[120],[160],[200]],"DEFAULT")
#		Bounties
		17, "BILLY":
			return make("Billy", "Take %s less dmg for every 1k bounty you have",
				[[2],[4],[6],[8]],"DEFAULT")
		18, "BHUNT":
			return make("Bounty Hunter", "Gain +%s%% dmg for every 100 bounty your enemy has",
				[[1],[1.5],[2],[2.5]],"DEFAULT")
		19, "HTH":
			return make("Hunt the Hunter", "Enemies with Bounty Hunter deal %sx bonus dmg to you",
				[[0.5],[0.25],[0.1],[0.05]],"DEFAULT")
		20, "SCO":
			return make("Self-Checkout", "Reaching your max bounty clears it and you gain %s%% of it. %s uses.",
				[[50, 2],[75, 2],[100, 3],[125, 4]],"DEFAULT")
#		Rewards
		21, "MOCT":
			return make("Moctezuma", "+%s base gold",
				[[6],[12],[18],[24]],"DEFAULT")
		22, "GBUMP":
			return make("Gold Bump", "+%s base gold",
				[[4],[8],[12],[16]],"DEFAULT")
		23, "GBOOST":
			return make("Gold Boost", "+%s%% gold",
				[[15],[30],[45],[60]],"DEFAULT")
		24, "XPBUMP":
			return make("XP Bump", "+%s base xp",
				[[4],[8],[12],[16]],"DEFAULT")
		25, "XPBOOST":
			return make("XP Boost", "+%s%% xp",
				[[10],[20],[30],[40]],"DEFAULT")
		26, "SWEATY":
			return make("Sweaty", "+%s%% streak bonus xp",
				[[50],[100],[200],[300]],"DEFAULT")
		_:
			return perk_data.new()

#Add color bbcode to certain words
func repl_desc(d : String) -> String:
	d = d.replace("dmg", "[color=" + C.COLOR_RED + "]dmg[/color]")
	d = d.replace("damage", "[color=" + C.COLOR_RED + "]damage[/color]")
	d = d.replace("gold", "[color=" + C.COLOR_GOLD + "]gold[/color]")
	d = d.replace("xp", "[color=" + C.COLOR_AQUA + "]xp[/color]")
	d = d.replace("hp", "[color=" + C.COLOR_GREEN + "]hp[/color]")
	
	#make inserted number green
	d = d.replace(" %s ", "[color=" + C.COLOR_GREEN + "] %s [/color]")
	d = d.replace(" +%s ", "[color=" + C.COLOR_GREEN + "] +%s [/color]")
	d = d.replace(" %s%% ", "[color=" + C.COLOR_GREEN + "] %s%% [/color]")
	d = d.replace(" +%s%% ", "[color=" + C.COLOR_GREEN + "] +%s%% [/color]")
	return d

#func get_key(id : String, a : person, key: String) -> Variant:
#	var data := perkinfo(id, a)
#	match key:
#		"Name":
#			return data.pname
#		"Desc":
#			return data.desc
#	return null
