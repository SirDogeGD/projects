extends Node2D

func _ready():
	perk_info.make_choice()
	update_perks()
	
func choose(num):
	you.perks.append(perk_info.choice[num])
	scene_handler.next_scene()

func update_perks():
	$CC/HBox/VBox/LabelName.set_text(perk_info.perkinfo(perk_info.choice[0]).get_name())
	$CC/HBox/VBox/LabelDesc.set_text(perk_info.perkinfo(perk_info.choice[0]).get_desc())
	$CC/HBox/VBox2/LabelName.set_text(perk_info.perkinfo(perk_info.choice[1]).get_name())
	$CC/HBox/VBox2/LabelDesc.set_text(perk_info.perkinfo(perk_info.choice[1]).get_desc())
	$CC/HBox/VBox3/LabelName.set_text(perk_info.perkinfo(perk_info.choice[2]).get_name())
	$CC/HBox/VBox3/LabelDesc.set_text(perk_info.perkinfo(perk_info.choice[2]).get_desc())

func _process(delta):
	if Input.is_action_just_pressed("inv_1"):
		choose(0)
	if Input.is_action_just_pressed("inv_2"):
		choose(1)
	if Input.is_action_just_pressed("inv_3"):
		choose(2)

func _on_VBox_gui_input(event):
	if event.is_action_pressed("attack"):
		choose(0)

func _on_VBox2_gui_input(event):
	if event.is_action_pressed("attack"):
		choose(1)

func _on_VBox3_gui_input(event):
	if event.is_action_pressed("attack"):
		choose(2)
