extends CenterContainer

var contractShowerContractFile = load("res://code/events/contract/contract_shower/c_show_label.gd")

func _ready():
	display_contracts()

func display_contracts():
	for c in contract_handler.active:
		var l = contractShowerContractFile.new()
		l.cont = c
		$HSplitContainer/VBoxContracts.add_child(l)
	
	for c in contract_handler.completed:
		var l = contractShowerContractFile.new()
		l.cont = c
		$HSplitContainer/VBoxContractsComp.add_child(l)
