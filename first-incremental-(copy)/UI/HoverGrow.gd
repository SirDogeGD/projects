extends Node

@export var target: NodePath   # drag & drop in the editor
@export var hover_scale: Vector2 = Vector2(1.2, 1.2)
@export var click_scale: Vector2 = Vector2(0.8, 0.8)
@export var tween_time: float = 0.15

var _tween: Tween

func _ready():
	if target == NodePath():
		target = ".."  # default to parent if none set
	connect_signals()

func connect_signals():
	# If the parent (or target) has mouse signals
	if get_node(target).has_signal("mouse_entered"):
		get_node(target).connect("mouse_entered", _on_mouse_entered)
	if get_node(target).has_signal("mouse_exited"):
		get_node(target).connect("mouse_exited", _on_mouse_exited)
	if get_node(target).has_signal("gui_input"):
		get_node(target).connect("gui_input", _on_pressed)
	
	#make the effect centered
	get_node(target).pivot_offset = get_node(target).size / 2

func _on_mouse_entered():
	animate_to(hover_scale)

func _on_mouse_exited():
	animate_to(Vector2.ONE)

func _on_pressed(event):
	if Input.is_action_just_pressed("left_click"):
		animate_to(click_scale)
		# bounce back to hover after shrink
		await get_tree().create_timer(tween_time).timeout
		animate_to(hover_scale)

func animate_to(target_scale: Vector2):
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(get_node(target), "scale", target_scale, tween_time)
