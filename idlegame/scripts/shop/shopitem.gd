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
	match state:
			2:
				$VBoxContainer/BBuy.set_text("bought")
			3:
				$VBoxContainer/BBuy.set_text("selected")
			_:
				$VBoxContainer/BBuy.set_text(str(price, " gold"))

#Buy Upgrade
func _on_BBuy_pressed():
	match state:
		1:
			if stats.gold >= int(self.price):
				stats.add_stats("g", -self.price)
				update()
