extends VBoxContainer

export(String, "you", "enemy") var who = "you"

var heart_full = preload("res://icons/ui/hp/hud_heartFull.png")
var heart_empty = preload("res://icons/ui/hp/hud_heartEmpty.png")
var heart_half = preload("res://icons/ui/hp/hud_heartHalf.png")
var shield_half = preload("res://icons/ui/hp/hud_shieldHalf.png")
var shield_full = preload("res://icons/ui/hp/hud_shieldHeart.png")

func update_health(value, max_hp, shield):
	
	for n in get_children():
		if n.name != "1": 
			remove_child(n)
			n.queue_free()
	
	for i in max_hp/2:
		add_child(TextureRect.new())
		if value > i * 2 + 1:
			add_heart(heart_full)
		elif value > i * 2:
			add_heart(heart_half)
		else:
			add_heart(heart_empty)

	for i in shield/2:
		add_child(TextureRect.new())
		if value > i * 2 + 1:
			add_heart(shield_full)
		elif value > i * 2:
			add_heart(shield_half)

func add_heart(t):
	var tr = TextureRect.new()
	tr.texture = t
	var placed = false
	
	if who == "you":
		for e in get_children():
			if e.get_child_count() < 10:
				e.add_child(tr)
				placed = true
		if not placed:
			var grid = GridContainer.new()
			grid.columns = 10
			add_child(grid)
			grid.add_child(tr)
			move_child(grid, 0)
	else:
		pass
