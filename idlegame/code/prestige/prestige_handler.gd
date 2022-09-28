extends Node

var itemFile = preload("res://code/prestige/pshopItem.tscn")

#Should always be changed to:
#(amount of shop items) + 1
var amount = 9

func _ready():
	pass

#create all available shop items and send them to
#prestigeShop.stock()
func make_shop_items():
	var Upgrades = []
	for n in amount:
		Upgrades.append(n)
#get upgrades players doesnt have
	var boughtUpgrades = stats.pUpgrades
	var pool = []
	for x in Upgrades.size():
		if not Upgrades[x] in boughtUpgrades:
			pool.append(Upgrades[x])
	var items = []
#check if theres less than 3 items left
	var items_left = pool.size()
	var items_shown = 3
	if items_shown > items_left:
		items_shown = items_left
#turn upgrades into shopItems
	for n in items_shown:
		var item = itemFile.instance()
		var info = item_list(pool[n])
		item.setup(info[0], info[1], info[2], info[3])
		items.append(item)
	return items

#remember when adding more xp bump/gold boost
#to add the ID to you.calc_xp/calc_gold
func item_list(id):
	match id:
#				  ID	Price	Name		Description
		0:
			return([0, 10, "Tenacity I", "heal +1 hp on kill"])
		1:
			return([1, 10, "Mysticism I", "new perks\n+1 perk slot"])
		2:
			return([2, 10, "Beastmode", "new Megastreak"])
		3:
			return([3, 50, "Tenacity II", "heal +1 hp on kill"])
		4:
			return([4, 5, "XP bump I", "get +1 xp on kill"])
		5:
			return([5, 5, "Gold boost I", "get +2.5% gold on kill"])
		6:
			return([6, 10, "Mysticism II", "new perks\n+1 perk slot"])
		7:
			return([7, 15, "Damage Numbers", "Show Damage"])
		8:
			return([8, 20, "Bounties", "Adds Bounties!"])
