extends Node2D

func _ready():
	check_bought()
	update_stats()

func _on_ContinueB_pressed():
	scene_handler.next_scene()

func buy(what):
	var cost
	match what:
		"sword":
			if check_price(200):
				you.perks.append(6)
		"boots":
			if check_price(300):
				you.perks.append(7)
		"cp":
			if check_price(500):
				you.perks.append(8)
	check_bought()
	update_stats()

func check_price(price):
	if stats.gold > price:
		stats.add_stats("g", -price)
		return true
	else:
		return false

func _on_B1_pressed():
	buy("sword")

func _on_B2_pressed():
	buy("boots")

func _on_B3_pressed():
	buy("cp")

func check_bought():
	if you.perks.has(6):
		$VBox/ShopItems/C1/B.text = "bought"
	if you.perks.has(7):
		$VBox/ShopItems/C2/B.text = "bought"
	if you.perks.has(8):
		$VBox/ShopItems/C3/B.text = "bought"

func update_stats():
	$VBox/LabelG.text = "Gold: " + String(stats.gold)
