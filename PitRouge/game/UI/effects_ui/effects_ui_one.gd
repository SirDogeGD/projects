extends CenterContainer
class_name effect_UI_one

var eff : String
var lvl : int

func update():
	var c := Constants.new()
	var l : RichTextLabel = $numLabel
	$icon.texture = load("res://img/effects/effect_" + eff + ".png")
	l.clear()
	l.push_outline_color(c.COLOR_BLACK)
	l.push_outline_size(5)
	l.push_font_size(30)
	l.append_text(str(lvl))
	l.pop()
	l.pop()
	l.pop()
