extends CanvasLayer
class_name perk_menu

var choice_container = preload("res://game/person/perks/perk_menu/perk_choose/perk_choose.tscn")

func _on_perk_chosen(id : String):
	new_choice()
	get_tree().call_group("player", "call_info")

func new_choice():
	var default := ["SHARP", "PUN", "K_BUST", "PF", "GAB", "BERS", "GUTS", "C_DMG", "C_SHIELD", "C_JAN", "C_CRUSH", "LS", "FSTRIKE"]
	var pool := default
	#remove perks player already has maxed
	for id in SAVE.pers.perks.get_maxed():
		pool.erase(id)
	#remove perks that wont fit into slots
	var can_fit_slots : Array[String]
	for id in pool:
		if SAVE.pers.perks.slot_not_full(id):
			can_fit_slots.append(id)
	pool = can_fit_slots.duplicate()
	pool.shuffle()
	
	#remove containers
	for c in %ChoiceContainer.get_children():
		c.queue_free()
	
	var choices = min(3, pool.size())
	for n in range(choices):
		var cc : perkchoose = choice_container.instantiate()
		cc.id = pool[n]
		cc.chosen.connect(_on_perk_chosen)
		%ChoiceContainer.add_child(cc)
		cc.update(SAVE.pers)

func update_tooltip(id : String, lvl : int, vis := false):
	if id != "EMPTY":
		%tooltip.visible = vis
		%tooltip.update(id, lvl)
