extends Control

var tag = "I can feel it"
var desc = "somethings wrong"
var price = 0
#states: 1=unbought 2=bought 3=selected
var state = 1
var buy = []

#price, tag (name), description, what it buys
func setup(p, t, d, s, b):
	self.price = p
	self.tag = t
	self.desc = d
	self.state = s
	self.buy = b
	update()

func update():
	$VBoxContainer/LName.set_text(str(tag))
	$VBoxContainer/LDesc.set_text(desc)

	check_state()
	
	match state:
			2:
				$VBoxContainer/BBuy.set_text("bought")
			3:
				$VBoxContainer/BBuy.set_text("selected")
			_:
				$VBoxContainer/BBuy.set_text(str(price, " gold"))

#Buy Item
func _on_BBuy_pressed():
	match state:

#		buys item
		1:
			if stats.gold >= int(self.price):
				match buy[0]:
					"mega":
						shop_handler.add_purchase(buy[1])
					"runshop":
						you.perks.append(buy[1])
						contract_handler.buy(buy[1])
						scene_handler.next_scene()
				state = 2
				stats.add_stats("g", -self.price)

#		selects item
		2:
			match buy[0]:
				"mega":
					you.mega = buy[1]
	get_tree().call_group("shopitem", "update")
	stats.save_Stats()

#check if item has been bought or not
func check_state():
	if state == 1:
		match buy[0]:
			"mega":
				if buy[1] in shop_handler.get_purchases():
					state = 2
	if state == 2:
		match buy[0]:
			"mega":
				if you.mega == buy[1]:
					state = 3
	if state == 3:
		match buy[0]:
			"mega":
				if you.mega != buy[1]:
					state = 2
