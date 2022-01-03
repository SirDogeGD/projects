extends Node2D

func _ready():
	contract_handler.make_choice()
	update_labels()

func c1():
	contract_handler.choose(0)

func c2():
	contract_handler.choose(1)

func c3():
	contract_handler.choose(2)

func _process(delta):
	if Input.is_action_just_pressed("inv_1"):
		c1()
	if Input.is_action_just_pressed("inv_2"):
		c2()
	if Input.is_action_just_pressed("inv_3"):
		c3()

func update_labels():
	$VBoxContainer/HBoxContainer/VBoxContainer/LContract1.set_text(make_text(1))
	$VBoxContainer/HBoxContainer/VBoxContainer2/LContract2.set_text(make_text(2))
	$VBoxContainer/HBoxContainer/VBoxContainer3/LContract3.set_text(make_text(3))

func make_text(num):
	var contract
	match num:
		1:
			contract = contract_handler.choices[0]
		2:
			contract = contract_handler.choices[1]
		3:
			contract = contract_handler.choices[2]

	match contract.get_type():
		"p":
			var perk = perk_info.perkinfo(contract.get_point()).get_name()
			return(str("Get ", contract.get_count(), " kills with ", perk))
		"k":
			return(str("Get ", contract.get_count(), " kills"))
		"b":
			var shopitem = perk_info.perkinfo(contract.get_point()).get_name()
			return(str("Buy ", shopitem))
		"e":
			return(str("Win a ", contract.get_point()))
