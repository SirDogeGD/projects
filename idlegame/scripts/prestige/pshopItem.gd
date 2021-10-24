extends Control

var tag = "I can feel it"
var desc = "somethings wrong"
var price = 0
var id = 0

#id, price (renown), tag (name), description
func setup(i, p, t, d):
	self.tag = t
	self.desc = d
	self.price = p
	self.id = i
	update()

func update():
	$VBoxContainer/LName.set_text(tag)
	$VBoxContainer/LDesc.set_text(desc)
	$VBoxContainer/BBuy.set_text(str(price, " renown"))

#Buy Upgrade
func _on_BBuy_pressed():
	if stats.renown >= self.price:
		stats.pUpgrades.append(self.id)
		stats.add_stats("r", -self.price)
		queue_free()
