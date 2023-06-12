extends MarginContainer

var id := "BARB"
var data : perk_data

func _ready():
	display()

func display():
	data = PINFO.perkinfo(id)
	%PerkIcon.texture = load("res://img/perks/perk_" + id + ".png")
	%PerkName.text = "[center]" + data.pname + "[/center]"
