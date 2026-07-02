extends Label
class_name resources_label

@export var type: GameState.types
var my_type_text : String

func update():
	my_type_text = GameState.get_name_of_type(type)
	text = my_type_text + ': ' + str(snapped(GameState.get_resource(my_type_text),0.1))

func boing():
	var t = create_tween()
	t.tween_property(self, "scale", Vector2(1.2, 1.2), 0.1)
	t.tween_property(self, "scale", Vector2.ONE, 0.1)
