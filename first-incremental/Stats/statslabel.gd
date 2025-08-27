extends Label

enum types {SOULS, WOOD, STONE}
@export var type: types

func update():
	var my_type : String
	match type:
		types.SOULS:
			my_type = 'Souls'
		types.WOOD:
			my_type = 'Wood'
		types.STONE:
			my_type = 'Stone'
	
	var my_amount = int(GameState.get_resource(my_type))
	if my_amount == 0:
		visible = false
	else:
		visible = true
		text = my_type + ': ' + str(my_amount)
