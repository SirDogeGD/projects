extends TextureRect

@export var slot # (int, 6)

func _ready():
	update_img()

func update_img():
	var i : item = you.inv[slot]
