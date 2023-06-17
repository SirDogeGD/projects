extends CanvasLayer

func _on_perk_chosen():
	new_choice()
	get_tree().call_group("player", "call_info")

func new_choice():
	var default := ["SHARP", "PUN", "K_BUST", "PF", "GAB", "BERS", "GUTS", "C_DMG", "C_SHIELD", "C_JAN", "C_CRUSH", "LS", "FSTRIKE"]
	var pool := default
	pool.shuffle()
	for n in %ChoiceContainer.get_child_count():
		var pc : perkchoose = %ChoiceContainer.get_child(n)
		pc.id = pool[n]
