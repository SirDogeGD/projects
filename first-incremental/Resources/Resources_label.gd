extends Label
class_name resources_label

enum types {SOULS, WOOD, STONE}
@export var type: types
var my_type : String

func update():
	if my_type == '':
		match type:
			types.SOULS:
				my_type = 'Souls'
			types.WOOD:
				my_type = 'Wood'
			types.STONE:
				my_type = 'Stone'
	
	text = my_type + ': ' + str(int(GameState.get_resource(my_type)))
