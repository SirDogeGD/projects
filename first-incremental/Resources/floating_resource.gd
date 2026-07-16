extends Node2D

@export var type: GameState.types
var origin : String
@export var travel_time := 0.8
@export var curve_height := 50.0
var target_ui: NodePath

var _tween: Tween

func _ready():
	set_target()
	start_flight(self, get_node(target_ui))

func start_flight(from_node: Node, to_node: Node):
	var from_pos = from_node.global_position
	var to_pos = to_node.global_position + to_node.size/2
	position = from_pos
	_tween = create_tween()
	# optional little curve (upward arc)
	var mid = (from_pos + to_pos) / 2 - Vector2(0, curve_height)
	_tween.tween_property(self, "position", mid, travel_time * 0.5).set_trans(Tween.TRANS_SINE)
	_tween.tween_property(self, "position", to_pos, travel_time * 0.5).set_trans(Tween.TRANS_SINE)
	_tween.tween_callback(Callable(self, "_on_reached_target"))

func _on_reached_target():
	queue_free()
	GameState.add_resource(GameState.get_name_of_type(type), UpgradeList.get_income("Soul Well"))
	if target_ui != NodePath():
		var ui_node = get_node(target_ui)
		if ui_node and ui_node.has_method("Update"):
			ui_node.Update()
	
	set_target()

func set_target():
	var nodes := get_tree().get_nodes_in_group("%s_counter" % GameState.get_name_of_type(type))
	if nodes.size() > 0:
		target_ui = nodes[0].get_path()
		return
	#doesnt exist yet
	if not get_node_or_null(target_ui):
		var statshowers := get_tree().get_nodes_in_group("statshower")
		if statshowers.size() > 0:
			target_ui = statshowers[0].get_path()
			return
		return
