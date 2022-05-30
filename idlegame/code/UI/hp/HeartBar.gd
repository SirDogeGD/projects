extends VBoxContainer

export(String, "you", "enemy") var who = "you"

var heart_full = preload("res://icons/ui/hp/hud_heartFull.png")
var heart_empty = preload("res://icons/ui/hp/hud_heartEmpty.png")
var heart_half = preload("res://icons/ui/hp/hud_heartHalf.png")
var shield_half = preload("res://icons/ui/hp/hud_shieldHalf.png")
var shield_full = preload("res://icons/ui/hp/hud_shieldHeart.png")

func update_health(value, max_hp, shield):
	
#	remove all children
	for n in get_children():
		remove_child(n)
		n.queue_free()
	
#	add hearts
	for i in max_hp/2:
		if value > i * 2 + 1:
			add_heart(heart_full)
		elif value > i * 2:
			add_heart(heart_half)
		else:
			add_heart(heart_empty)
	
#	add shield hearts
	for i in shield/2:
		if value > i * 2 + 1:
			add_heart(shield_full)
		elif value > i * 2:
			add_heart(shield_half)

func add_heart(t):
	var tr = TextureRect.new()
	tr.texture = t
	tr.size_flags_horizontal = SIZE_SHRINK_CENTER
	tr.size_flags_vertical = SIZE_SHRINK_CENTER
	var placed = false
	var grid : GridContainer
	
#	make sure there is at least one grid
	if get_child_count() < 1:
		add_child(new_grid())
	
	grid = get_child(0)
	
#	players hpbar needs this extra BS
	if who == "you":
		for e in get_children():
			if e.get_child_count() < 10:
				grid = e
				placed = true
#		if all grids are full add a new one
		if not placed:
			grid = new_grid()
			add_child(grid)
			move_child(grid, 0)
	
	grid.add_child(tr)

func new_grid():
	var newgrid = GridContainer.new()
	newgrid.columns = 10
	newgrid.size_flags_vertical = SIZE_FILL
	return newgrid
