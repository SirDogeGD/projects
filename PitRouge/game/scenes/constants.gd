extends Node
class_name Constants

const COLOR_DARK_RED = "#AA0000"
const COLOR_RED = "#FF5555"
const COLOR_GOLD = "#FFAA00"
const COLOR_YELLOW = "#FFFF55"
const COLOR_DARK_GREEN = "#00AA00"
const COLOR_GREEN = "#55FF55"
const COLOR_AQUA = "#55FFFF"
const COLOR_DARK_AQUA = "#00AAAA"
const COLOR_DARK_BLUE = "#0000AA"
const COLOR_BLUE = "#5555FF"
const COLOR_PINK = "#FF55FF"
const COLOR_PURPLE = "#AA00AA"
const COLOR_WHITE = "#FFFFFF"
const COLOR_GREY = "#AAAAAA"
const COLOR_DARK_GREY := "#555555" 
const COLOR_BLACK = "#000000"

#Add color bbcode to certain words
static func repl(d : String) -> String:
	d = d.replace("dmg", "[color=" + COLOR_RED + "]dmg[/color]")
	d = d.replace("damage", "[color=" + COLOR_RED + "]damage[/color]")
#	GOLD
	d = d.replace("gold", "[color=" + COLOR_GOLD + "]gold[/color]")
	d = d.replace("GOLD", "[color=" + COLOR_GOLD + "]GOLD[/color]")
	d = d.replace("+%sG", "[color=" + COLOR_GOLD + "]+%sG[/color]")
#	XP
	d = d.replace("+%sXP", "[color=" + COLOR_AQUA + "]+%sXP[/color]")
	d = d.replace("XP", "[color=" + COLOR_AQUA + "]XP[/color]")
	d = d.replace("xp", "[color=" + COLOR_AQUA + "]xp[/color]")
	
	d = d.replace("DIA", "[color=" + COLOR_AQUA + "]DIA[/color]")
	d = d.replace("hp", "[color=" + COLOR_GREEN + "]hp[/color]")
	d = d.replace("Weakness", "[color=" + COLOR_PURPLE + "]Weakness[/color]")
	d = d.replace("shield", "[color=" + COLOR_GREY + "]shield[/color]")
	
	#make inserted number green
	d = d.replace(" %s ", "[color=" + COLOR_GREEN + "] %s [/color]")
	d = d.replace(" +%s ", "[color=" + COLOR_GREEN + "] +%s [/color]")
	d = d.replace(" %s%% ", "[color=" + COLOR_GREEN + "] %s%% [/color]")
	d = d.replace(" +%s%% ", "[color=" + COLOR_GREEN + "] +%s%% [/color]")
	return d
