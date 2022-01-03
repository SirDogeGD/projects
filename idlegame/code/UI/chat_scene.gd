extends Label

func _ready():
	update_label()

func update_label():
	set_text(chat.make_chat())

func item_data(i):
	var n = i.get_name()
	var desc = ""
	var sword = load("res://code/items/sword.gd")
	var heal = load("res://code/items/heal.gd")
	
	match i.get_script():
		sword:
			desc = "Deals " + str(i.get_damage()) + " dmg"
		heal:
			desc = heal_text(i)
	
	set_text(str(n) + "\n==============\n" + str(desc))

func heal_text(i):
	var text = "Heals "
	var types = 0
#HP
	if i.get_hp() > 0:
		types += 1
		text += str(i.get_hp()) + " hp"
#Shield
	if i.get_shield() > 0:
		types += 1
		if types > 1:
			text += " and "
		text += str(i.get_shield()) + " shield"
#Effects
	if !i.get_effects().empty():
		text += "\n"
		for e in i.get_effects():
			match e.get_name():
				"r":
					text += "Regeneration " + str(e.get_level()) + " (" + str(e.get_duration()) + " turns)\n"
	return text
