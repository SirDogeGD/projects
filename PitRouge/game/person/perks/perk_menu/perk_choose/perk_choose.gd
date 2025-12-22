extends MarginContainer
class_name perkchoose

signal chosen(id : String)
signal no_space(id : String)
signal no_shards(id : String)

var id := "BARB"
var data : perk_data
var is_chosen := false

func _ready():
	pass
#	get_tree().call_group("player", "call_info")

func update(a : person):
	data = PINFO.perkinfo(id, a, true)
	var lvl := str(a.perks.count(id) + 1) 
	%PerkIcon.texture = PINFO.get_pic(id)
	%PerkName.text = "[center][b]" + data.pname + " " + lvl + "[/b][/center]"
	%PerkDesc.text = "[center]" + data.desc + "[/center]"

#CHOOSE A PERK
func _on_click(event):
	if Input.is_action_just_pressed("left_click"):
		var player = get_tree().get_first_node_in_group("player")
		if player.mystic_shards > 0:
			if player.perks.slot_not_full(id):
				player.perks.add(id)
				player.mystic_shards -= 1
				is_chosen = true
				emit_signal("chosen", id)
			else:
				emit_signal("no_space", id)
		else:
			emit_signal("no_shards", id)

func _on_mouse_entered():
	var m := load("res://game/UI/outline.tres")
	%Panel.material = m #add outline

func _on_mouse_exited():
	if not is_chosen:
		%Panel.material = null #remove outline

func _on_visibility_changed():
	if not visible:
		%Panel.material = null
