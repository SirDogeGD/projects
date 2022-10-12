extends TextureRect

export(int, 6) var slot

func _ready():
	update_img()

func update_img():
	var i : item = you.inv[slot]
