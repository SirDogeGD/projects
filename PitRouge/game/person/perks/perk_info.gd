extends Node
	
var pdict := {
	"Name" : "",
	"Desc" : "",
	"Nums" : [],
	"Type" : ""
}

func perkinfo(id) -> Dictionary:
	match id:
		0, "BARB":
			return make("Barbarian", "Your weapon deals +%s dmg",
				[[1],[1.1],[1.2],[1.3]],"DEFAULT")
		1, "SHARP":
			return make("Sharp", "Deal +%s%% melee damage",
				[[4],[8],[12],[16]],"DEFAULT")
		2, "PUN":
			return make("Punisher", "Deal +%s%% damage vs. players below 50%% HP",
				[[6],[12],[18],[24]],"DEFAULT")
		3, "K_BUST":
			return make("King Buster", "Deal +%s%% damage vs. players above 50%% HP",
				[[7],[13],[19],[25]],"DEFAULT")
		4, "PF":
			return make("Pain Focus", "Deal +%s%% damage per hp❤ you're missing",
				[[2],[3],[4],[5]],"DEFAULT")
		5, "GAB":
			return make("Gold and Boosted", "Deal +%s%% damage when you have shield hp",
				[[5],[10],[15],[20]],"DEFAULT")
		6, "DIA_BOOT":
			return make("Diamond boots", "Take %s less dmg",
				[[5],[6],[7],[8]],"DEFAULT")
		7, "DIA_CHEST":
			return make("Diamond Chestplate", "Take %s less dmg",
				[[6],[7],[8],[9]],"DEFAULT")
		8, "DIA_SWORD":
			return make("Diamond Sword", "Your weapon deals +%s dmg",
				[[1],[1.1],[1.2],[1.3]],"DEFAULT")
#			mysticism 1
		9, "BERS":
			return make("Berserker", "%s%% chance to crit",
				[[12],[20],[28],[36]],"DEFAULT")
		10, "GUTS":
			return make("Guts", "Heal %shp on kill",
				[[0.25],[0.4],[0.55],[0.7]],"DEFAULT")
		11, "C_DMG":
			return make("Combo: Damage", "Every fourth strike deals +%s%% damage",
				[[20],[30],[40],[50]],"DEFAULT")
		12, "C_SHIELD":
			return make("Combo: Shield", "Every fourth strike gives %s shield hp",
				[[0.8],[1],[1.2],[1.4]],"DEFAULT")
#		mysticism 2
		13, "C_JAN":
			return make("Counter-Janitor", "Gain Resistance I (%s turns) on kill",
				[[2],[3],[4],[5]],"DEFAULT")
		14, "C_CRUSH":
			return make("Combo: Crush", "Every fourth strike apply Weakness I for %s turn",
				[[1],[2],[3],[4]],"DEFAULT")
		15, "LS":
			return make("Lifesteal", "Heal for %s%% of damage dealt",
				[[4],[8],[12],[16]],"DEFAULT")
		16, "FSTRIKE":
			return make("First Strike", "Deal +%s%% dmg against enemies above 90% health",
				[[35],[40],[45],[50]],"DEFAULT")
#		Bounties
		17, "BILLY":
			return make("Billy", "Take %s less dmg for every 1k bounty you have",
				[[1],[2],[3],[4]],"DEFAULT")
		18, "BHUNT":
			return make("Bounty Hunter", "Gain +%s%% dmg for every 100 bounty your enemy has",
				[[1],[1.5],[2],[2.5]],"DEFAULT")
		19, "HTH":
			return make("Hunt the Hunter", "Enemies with Bounty Hunter deal %sx bonus dmg to you",
				[[0.5],[0.25],[0.1],[0]],"DEFAULT")
		20, "SCO":
			return make("Self-Checkout", "Reaching your max bounty clears it and you gain %s%% of it. %s uses.",
				[[50, 2],[75, 2],[100, 3],[125, 4]],"DEFAULT")
	return pdict

func make(name: String, desc: String, nums: Array, perkType: String) -> Dictionary:
	var perkDict := pdict.duplicate()
	perkDict["Name"] = name
	perkDict["Desc"] = desc
	perkDict["Nums"] = nums
	perkDict["Type"] = perkType
	return perkDict

func get_key(id, key: String) -> Variant:
	var perkDict := perkinfo(id)
	return perkDict.get(key, null)
