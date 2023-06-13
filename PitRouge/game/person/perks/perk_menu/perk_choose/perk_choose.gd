extends MarginContainer
class_name perkchoose

signal chosen

var id := "BARB"
var data : perk_data

func _ready():
	get_tree().call_group("player", "call_info")

func update(a : person):
	data = PINFO.perkinfo(id, a)
	var lvl := a.perks.count(id) + 1
	%PerkIcon.texture = load("res://img/perks/perk_" + id + ".png")
	%PerkName.text = "[center][b]" + data.pname + " " + str(lvl) + "[/b][/center]"
	%PerkDesc.text = "[center]" + data.desc + "[/center]"

#CHOOSE A PERK
func _on_click(event):
	if Input.is_action_just_pressed("left_click"):
		if SAVE.playerpers.mystic_shards > 0:
			SAVE.playerpers.perks.append(id)
			SAVE.playerpers.mystic_shards -= 1
			emit_signal("chosen")
		else:
			print("IDOT")
