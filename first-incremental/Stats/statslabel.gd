extends Label

enum types {MONEY, INCOME}
@export var type: types

func update():
	match type:
		types.MONEY:
			text = 'Money: ' + str(GameState.money)
		types.INCOME:
			text = 'Income: ' + str(IncomeTimer.calc_income())
