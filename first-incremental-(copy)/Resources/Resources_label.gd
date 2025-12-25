extends Label
class_name resources_label

@export var type: GameState.types
var my_type : String

func update():
	
	var t = create_tween()
	t.tween_property(self, "scale", Vector2(1.3, 1.3), 0.1)
	t.tween_property(self, "scale", Vector2.ONE, 0.1)
	
	if my_type == '':
		match type:
			GameState.types.SOULS:
				my_type = 'Souls'
				add_to_group("soul_label")
			GameState.types.WOOD:
				my_type = 'Wood'
				add_to_group("wood_label")
			GameState.types.STONE:
				my_type = 'Stone'
				add_to_group("stone_label")
	
	text = my_type + ': ' + str(int(GameState.get_resource(my_type)))
