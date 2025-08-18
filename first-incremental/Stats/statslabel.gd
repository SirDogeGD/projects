extends Label

enum types {SOULS, WOOD, STONE}
@export var type: types

func update():
	match type:
		types.SOULS:
			text = 'Souls: ' + str(GameState.get_resource("Souls")) 
		types.WOOD:
			text = 'Wood: ' + str(GameState.get_resource("Wood")) 
