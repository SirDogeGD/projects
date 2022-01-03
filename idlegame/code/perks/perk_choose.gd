extends Node2D

func _ready():
	perk_info.make_choice()
	update_perks()
	
func choose(num):
	you.perks.append(perk_info.choice[num])
	scene_handler.next_scene()

func c1():
	choose(0)

func c2():
	choose(1)

func c3():
	choose(2)

func update_perks():
	$HBoxContainer/VBox/LabelName.set_text(perk_info.perkinfo(perk_info.choice[0]).get_name())
	$HBoxContainer/VBox/LabelDesc.set_text(perk_info.perkinfo(perk_info.choice[0]).get_desc())
	$HBoxContainer/VBox2/LabelName.set_text(perk_info.perkinfo(perk_info.choice[1]).get_name())
	$HBoxContainer/VBox2/LabelDesc.set_text(perk_info.perkinfo(perk_info.choice[1]).get_desc())
	$HBoxContainer/VBox3/LabelName.set_text(perk_info.perkinfo(perk_info.choice[2]).get_name())
	$HBoxContainer/VBox3/LabelDesc.set_text(perk_info.perkinfo(perk_info.choice[2]).get_desc())

func _process(delta):
	if Input.is_action_just_pressed("inv_1"):
		c1()
	if Input.is_action_just_pressed("inv_2"):
		c2()
	if Input.is_action_just_pressed("inv_3"):
		c3()
