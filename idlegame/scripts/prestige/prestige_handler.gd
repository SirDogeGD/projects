extends Node

var itemFile = preload("res://scripts/prestige/pshopItem.tscn")

func _ready():
	pass

#create all available shop items and send them to
#prestigeShop.stock()
func make_shop_items():
	var Upgrades = []
	for n in 3:
		Upgrades.append(n)
#	get upgrades players doesnt have
	var boughtUpgrades = stats.pUpgrades
	var pool = []
	for x in Upgrades.size():
		if not Upgrades[x] in boughtUpgrades:
			pool.append(Upgrades[x])
#	turn upgrades into shopItems
	var items = []
	for n in pool.size():
		var item = itemFile.instance()
		var info = item_list(pool[n])
		item.setup(info[0], info[1], info[2], info[3])
		items.append(item)
	return items

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
