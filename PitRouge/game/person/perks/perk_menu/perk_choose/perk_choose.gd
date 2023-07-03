extends MarginContainer
class_name perkchoose

signal chosen

var id := "BARB"
var data : perk_data

func _ready():
	get_tree().call_group("player", "call_info")

func update(a : person):
	data = PINFO.perkinfo(id, a)
	var lvl := str(a.perks.count(id) + 1) 
	%PerkIcon.texture = load("res://img/perks/perk_" + id + ".png")
	%PerkName.text = "[center][b]" + data.pname + " " + lvl + "[/b][/center]"
	%PerkDesc.text = "[center]" + data.desc + "[/center]"

#CHOOSE A PERK
func _on_click(event):
	if Input.is_action_just_pressed("left_click"):
		if SAVE.pers.mystic_shards > 0:
			SAVE.pers.perks.add(id)
			SAVE.pers.mystic_shards -= 1
			emit_signal("chosen")
		else:
			print("IDOT")

func _on_mouse_entered():
	var m := load("res://game/UI/outline.tres")
	%Panel.material = m

func _on_mouse_exited():
	%Panel.material = null
