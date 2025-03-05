extends Node

var pers : person
var perkid : String
var C := Constants.new()
var n := false #use next nums (for perk choice)

func make(nam: String, desc: String, nums: Array[Array], type: String) -> perk_data:
	var data := perk_data.new()
	data.pname = nam
	var lvl = pers.perks.count(perkid)
	if n:
		lvl += 1
	lvl = max(1, lvl) #at least 0
	data.desc = repl_desc(desc) % nums[lvl - 1]
	data.nums = nums
	data.type = type
	return data

func perkinfo(id : String, a : person, next := false) -> perk_data:
	perkid = id
	pers = a
	n = next
	
	match id:
		0, "BARB":
			return make("Barbarian", "Your weapon deals +%s base dmg. Lose the ability to block",
				[[0.5],[0.9],[1.3],[1.7]],"SWORD")
		1, "SHARP":
			return make("Sharp", "Deal +%s%% melee damage",
				[[8],[16],[24],[32]],"SWORD")
		2, "PUN":
			return make("Punisher", "Deal +%s%% damage vs. players below 50%% HP",
				[[9],[18],[27],[36]],"SWORD")
		3, "K_BUST":
			return make("King Buster", "Deal +%s%% damage vs. players above 50%% HP",
				[[10],[20],[30],[40]],"SWORD")
		4, "PF":
			return make("Pain Focus", "Deal +%s%% damage per hp❤ you're missing",
				[[3],[4],[5],[6]],"SWORD")
		5, "GAB":
			return make("Gold and Boosted", "Deal +%s%% damage per shield heart you have",
				[[3],[4],[5],[6]],"SWORD")
		6, "DIA_BOOT":
			return make("Diamond boots", "Take %s%% less dmg",
				[[8],[16],[24],[32]],"DEF")
		7, "DIA_CHEST":
			return make("Diamond Chestplate", "Take %s%% less dmg",
				[[9],[18],[27],[36]],"DEF")
		8, "DIA_SWORD":
			return make("Diamond Sword", "Your weapon deals +%s base dmg",
				[[0.4],[0.8],[1.2],[1.6]],"SWORD")
		9, "BERS":
			return make("Berserker", " +%s%% crit chance",
				[[12],[20],[28],[36]],"SWORD")
		10, "GUTS": 
			return make("Guts", "Heal %s hp on kill",
				[[1.5],[2.5],[3.5],[5]],"SWORD")
		11, "C_DMG":
			return make("Combo: Damage", "Every fourth strike deals +%s%% damage",
				[[50],[75],[100],[150]],"SWORD")
		12, "C_SHIELD":
			return make("Combo: Shield", "Every fourth strike gives %s shield hp",
				[[1],[1.5],[2],[3]],"SWORD")
		13, "C_JAN":
			return make("Counter-Janitor", "Gain %s Resistance (%s sec) on kill",
				[[4, 4],[5, 4.5],[6, 5],[7, 5]],"SWORD")
		14, "C_CRUSH":
			return make("Combo: Crush", "Every fourth strike apply %s Weakness (%s sec)",
				[[2, 2],[3, 2.5],[4, 3],[5, 3.5]],"SWORD")
		15, "LS":
			return make("Lifesteal", "Heal for %s%% of damage dealt",
				[[4],[8],[12],[16]],"SWORD")
		16, "FSTRIKE":
			return make("First Strike", "Deal +%s%% dmg against enemies above 95%% hp",
				[[75],[120],[160],[200]],"SWORD")
#		Bounties
		17, "BILLY":
			return make("Billy", "Take %s less dmg for every 1k bounty you have",
				[[2],[4],[6],[8]],"DEF")
		18, "BHUNT":
			return make("Bounty Hunter", "Gain +%s%% dmg for every 100 bounty your enemy has",
				[[1],[1.5],[2],[2.5]],"SWORD")
		19, "HTH":
			return make("Hunt the Hunter", "Enemies with Bounty Hunter deal %sx bonus dmg to you",
				[[0.5],[0.25],[0.1],[0.05]],"DEF")
		20, "SCO":
			return make("Self-Checkout", "Reaching your max bounty clears it and you gain %s%% of it.",
				[[50],[75],[100],[125]],"GXP")
#		Rewards
		21, "MOCT":
			return make("Moctezuma", "+%s base gold",
				[[6],[12],[18],[24]],"GXP")
		22, "GBUMP":
			return make("Gold Bump", "+%s base gold",
				[[4],[8],[12],[16]],"GXP")
		23, "GBOOST":
			return make("Gold Boost", "+%s%% gold",
				[[15],[30],[45],[60]],"GXP")
		24, "XPBUMP":
			return make("XP Bump", "+%s base xp",
				[[4],[8],[12],[16]],"GXP")
		25, "XPBOOST":
			return make("XP Boost", "+%s%% xp",
				[[10],[20],[30],[40]],"GXP")
		26, "SWEATY":
			return make("Sweaty", "+%s%% streak bonus xp",
				[[50],[100],[200],[300]],"GXP")
		_:
			return perk_data.new()

#Add color bbcode to certain words
func repl_desc(d : String) -> String:
	d = d.replace("dmg", "[color=" + C.COLOR_RED + "]dmg[/color]")
	d = d.replace("damage", "[color=" + C.COLOR_RED + "]damage[/color]")
	d = d.replace("gold", "[color=" + C.COLOR_GOLD + "]gold[/color]")
	d = d.replace("xp", "[color=" + C.COLOR_AQUA + "]xp[/color]")
	d = d.replace("hp", "[color=" + C.COLOR_GREEN + "]hp[/color]")
	d = d.replace("Weakness", "[color=" + C.COLOR_PURPLE + "]Weakness[/color]")
	
	#make inserted number green
	d = d.replace(" %s ", "[color=" + C.COLOR_GREEN + "] %s [/color]")
	d = d.replace(" +%s ", "[color=" + C.COLOR_GREEN + "] +%s [/color]")
	d = d.replace(" %s%% ", "[color=" + C.COLOR_GREEN + "] %s%% [/color]")
	d = d.replace(" +%s%% ", "[color=" + C.COLOR_GREEN + "] +%s%% [/color]")
	return d

#perks that use a radius
func area_perks(id : String) -> int:
	match id:
		"SHARK":
			return 12
		"SOLI":
			return 7
		"SAP":
			return 8
		"PMBA":
			return 15
		"GLAD":
			return 10
		_:
			return 0

#perks that use a timer
func timer_perks(id : String) -> int:
	return 0

func get_pic(id : String) -> Texture:
	return load("res://img/perks/perk_" + id + ".png")

func get_combo_perks() -> Array[String]:
	return ['C_DMG', 'C_SHIELD', 'C_CRUSH']
