extends CenterContainer

var contractShowerContractFile = load("res://code/events/contract/contract_shower/c_show_label.gd")

func _ready():
	display_perks()

func display_perks():
	for c in contract_handler.active:
		var l = contractShowerContractFile.new()
		l.cont = c
		$HSplitContainer/VBoxContracts.add_child(l)

func dsp_perk_info(cont):
	var l = get_node("HSplitContainer/VBoxContractInfo/LabelContractInfo")
