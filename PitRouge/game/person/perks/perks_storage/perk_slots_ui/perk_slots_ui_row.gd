extends HBoxContainer

var perk_one = preload("res://game/person/perks/perks_storage/perk_slots_ui/perk_slots_ui_one.tscn")

@export_enum("GXP", "HEAL", "SWORD", "BOW", "DEF", "MOVE") \
var type : String

func _ready():
	get_tree().call_group("player", "call_info")

func update(a : person):
	#remove slots
	for c in get_children():
		c.queue_free()
	
	var amount_of_slots := SAVE.pers.perks.get_max(type)
	var perks : Array = SAVE.pers.perks.slots[type].keys()
	for n in range(amount_of_slots):
		var po : perk_slot_one = perk_one.instantiate()
		
		if n < perks.size(): #not empty
			po.id = perks[n]
			po.lvl = SAVE.pers.perks.slots[type][perks[n]]
		
		add_child(po)
		po.mouse_entered.connect(%tooltip.update.bind(po.id, SAVE.pers))
		po.mouse_exited.connect(%tooltip.update.bind(po.id, SAVE.pers, false))
		po.update()
