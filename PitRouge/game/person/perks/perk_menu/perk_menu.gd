extends CanvasLayer
class_name perk_menu

var choice_container = preload("res://game/person/perks/perk_menu/perk_choose/perk_choose.tscn")

func _physics_process(delta):
	if SCENE.current_scene_id == 'fight':
		if Input.is_action_just_pressed("tab"):
			get_tree().paused = true
			self.show()
		if Input.is_action_just_released("tab"):
			get_tree().paused = false
			self.hide()

func _on_perk_chosen(id : String):
	new_choice()
	get_tree().call_group("player", "call_info")

func new_choice():
	var p = PREF.getp()
	var default := ["SHARP", "PUN", "K_BUST", "PF", "GAB", "BERS", "GUTS", "C_DMG", "C_SHIELD", "C_JAN", "C_CRUSH", "LS", "FSTRIKE"]
	var pool := default
	#remove perks player already has maxed
	for id in p.perks.get_maxed():
		pool.erase(id)
	#remove perks that wont fit into slots
	var can_fit_slots : Array[String]
	for id in pool:
		if p.perks.slot_not_full(id):
			can_fit_slots.append(id)
	pool = can_fit_slots.duplicate()
	pool.shuffle()
	
	#remove containers
	for c : perkchoose in %ChoiceContainer.get_children():
		c.call_deferred("queue_free")
	
	var choices = min(3, pool.size())
	for n in range(choices):
		var cc : perkchoose = choice_container.instantiate()
		cc.id = pool[n]
		cc.chosen.connect(_on_perk_chosen)
		%ChoiceContainer.add_child(cc)
		cc.update(PREF.getp())

func update_tooltip(id : String, lvl : int, vis := false):
	if id != "EMPTY":
		%tooltip.visible = vis
		%tooltip.update(id, lvl)
