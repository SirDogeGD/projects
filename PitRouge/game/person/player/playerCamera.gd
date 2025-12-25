extends Camera2D

const ZOOM_OUT_FACTOR = 0.1
const SPEED_THRESHOLD = 50

@onready var following : player
var initialZoom: Vector2

func _ready():
	PREF.player_ready.connect(start, CONNECT_ONE_SHOT)
	initialZoom = zoom
	
func start(p : player):
	following = p

func _process(delta):
	if following != null:
#		position = following.position
		global_position = following.global_position
		zoom = initialZoom
#		var zoomOutAmount = int((following.SPEED - 300) / SPEED_THRESHOLD) * ZOOM_OUT_FACTOR
#		zoom.x = initialZoom.x * (1 - zoomOutAmount / 80)
#		zoom.y = initialZoom.y * (1 - zoomOutAmount / 80)
