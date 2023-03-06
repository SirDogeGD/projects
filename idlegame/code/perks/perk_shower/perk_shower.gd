extends CenterContainer

var perkshowerperkFile = load("res://code/perks/perk_shower/perk_shower_perk.gd")

func _ready():
	display_perks()

func display_perks():
	for e in you.perks:
		var l = perkshowerperkFile.new()
		l.connect("hovered_on",Callable(self,"dsp_perk_info"))
		l.pid = e
		$HSplitContainer/VBoxPerks.add_child(l)

func dsp_perk_info(pid):
	$HSplitContainer/VBoxPerkInfo/LabelPerkInfo.text = make_text(pid)

func make_text(pid):
	var perk = perk_info.perkinfo(pid)
	var name = perk.get_name()
	var desc = perk.get_desc()
	var text = str(name) + "\n========================\n" + str(desc)
	return text
