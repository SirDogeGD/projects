extends GridContainer

export(String, "you", "enemy") var who = "you"

var heart_full = preload("res://icons/ui/hp/hud_heartFull.png")
var heart_empty = preload("res://icons/ui/hp/hud_heartEmpty.png")
var heart_half = preload("res://icons/ui/hp/hud_heartHalf.png")
var shield_half = preload("res://icons/ui/hp/hud_shieldHalf.png")
var shield_full = preload("res://icons/ui/hp/hud_shieldHeart.png")

func update_health(value, max_hp, shield):
	
	for n in get_children():
		remove_child(n)
		n.queue_free()
	
	for i in max_hp/2:
		add_child(TextureRect.new())
		if value > i * 2 + 1:
			get_child(i).texture = heart_full
		elif value > i * 2:
			get_child(i).texture = heart_half
		else:
			get_child(i).texture = heart_empty

	for i in shield/2:
		add_child(TextureRect.new())
		if value > i * 2 + 1:
			get_child(i).texture = shield_full
		elif value > i * 2:
			get_child(i).texture = shield_half
