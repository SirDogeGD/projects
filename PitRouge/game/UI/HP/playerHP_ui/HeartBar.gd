extends VBoxContainer
class_name ui_heartbar

var heart_full := preload("res://IMG/UI/HP/hud_heartFull.png")
var heart_empty := preload("res://IMG/UI/HP/hud_heartEmpty.png")
var heart_half := preload("res://IMG/UI/HP/hud_heartHalf.png")
var shield_half := preload("res://IMG/UI/HP/hud_shieldHalf.png")
var shield_full := preload("res://IMG/UI/HP/hud_shieldHeart.png") 

func update_health(hp : hp_data):
	
	var health = hp.curHP
	var max_hp = hp.maxHP
	var shield = hp.curSH
	
#	remove all children
	for n in get_children():
		remove_child(n)
		n.queue_free()
	
#	add hearts
	var amount_hearts := snappedi(round(max_hp), 2) / 2
	for i in amount_hearts:
		if health >= (i + 1) * 2:
			add_heart(heart_full)
		elif health >= (i + 1) * 2 - 1:
			add_heart(heart_half)
		else:
			add_heart(heart_empty)
	
#	add shield hearts
	var amount_shield_hearts := snappedi(round(shield), 2) / 2
	for i in amount_shield_hearts:
		if shield >= (i + 1) * 2:
			add_heart(shield_full)
		else:
			add_heart(shield_half)

func add_heart(t):
	var tr = TextureRect.new()
	tr.texture = t
	tr.size_flags_horizontal = SIZE_SHRINK_CENTER
	tr.size_flags_vertical = SIZE_SHRINK_CENTER
	var grid : GridContainer
	
#	make sure there is at least one grid
	if get_child_count() < 1:
		add_child(new_grid())
	
#	get "top" grid
	grid = get_child(0)
	
#	once a GridContainer is filled, make a new one
	if grid.get_child_count() == 10:
		grid = new_grid()
		add_child(grid)
		move_child(grid, 0)
	
	grid.add_child(tr)

func new_grid():
	var newgrid = GridContainer.new()
	newgrid.columns = 10
	newgrid.layout_direction = Control.LAYOUT_DIRECTION_LTR
	return newgrid
