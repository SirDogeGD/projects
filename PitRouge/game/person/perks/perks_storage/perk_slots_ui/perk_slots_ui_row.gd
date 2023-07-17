extends HBoxContainer

var perk_one = preload("res://game/person/perks/perks_storage/perk_slots_ui/perk_slots_ui_one.tscn")

@export_enum("GXP", "HEAL", "SWORD", "BOW", "DEF", "MOVE") \
var type: String

func _ready():
	update()

func update():
	#remove slots
	for c in get_children():
		c.queue_free()
	
	var amount_of_slots := SAVE.pers.perks.get_max(type)
	var perks : Array[String] = SAVE.pers.perks.slots[type].values()
	for n in range(amount_of_slots):
		var po : perk_slot_one = perk_one.instantiate()
		
		if n <= perks.size(): #not empty
			po.id = perks[n]
			po.lvl = SAVE.pers.perks.slots[type][perks[n]]
		
		add_child(po)
		po.update()
