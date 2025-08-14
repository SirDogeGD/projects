extends Label

enum types {SOULS, INCOME}
@export var type: types

func update():
	match type:
		types.SOULS:
			text = 'Souls: ' + str("%.2f" % GameState.get_resource("Souls")) 
		types.INCOME:
			text = 'Income: ' + str(Calculations.calc_income())
