extends weapon
class_name melee

var _velocity := Vector2.ZERO

func left_click() -> void:
	#cant attack while blocking
	if not animation_player.current_animation == "block": 
		animation_player.play("RESET")
		await animation_player.animation_finished
		animation_player.play("stab")

func right_click():
	if PERKS.can_block(owner):
		#set persons item_slow true
		if owner.get("item_slow") != null:
			owner.item_slow = true
		#play block "animation"
		animation_player.play("RESET")
		await animation_player.animation_finished
		animation_player.play("block")

func stop_right_click():
	#set persons item_slow false
	if owner.get("item_slow") != null:
		owner.item_slow = false
	#unblock
	if animation_player.current_animation == "block":
		animation_player.play("RESET")
