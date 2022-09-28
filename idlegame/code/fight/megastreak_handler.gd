extends Node

var o = "overdrive"
var b = "beastmode"
var h = "highlander"
var dmg : float = 0
var g : guy

#gets called by guy
func get_all(who : guy, s):
	g = who
	var mega = g.mega
	
	if(check_activated(mega, s)):
		if not g.mactive:
			chat.mega(mega)
		g.mactive = true
	
	var arr = []
	arr.append(get_true(mega, s))
	arr.append(get_dmg(mega, s))
	arr.append(get_gboost(mega, s))
	arr.append(get_xpboost(mega, s))
	arr.append(get_dmgboost(mega, s))
	return(arr)

#true dmg taken
func get_true(name, s):
	dmg = 0
	match name:
		o:
			if s >= 10:
				var dmg : float = ((float(s) - 10) / 5) / 10
	return dmg

#extra dmg taken
func get_dmg(name, s):
	dmg = 0
	match name:
		b:
			if s >= 20:
				dmg = ((float(s) - 10) / 5) / 10
	return dmg

func get_gboost(name, s):
	match name:
		o:
			if s >= 10:
				return 0.5
		b:
			if s>= 20:
				return 0.75
		h:
			if s>= 20:
				return 1.1
	return 0

func get_xpboost(name, s):
	match name:
		o:
			if s >= 10:
				return 1
		b:
			if s>= 20:
				return 0.5
	return 0

func get_dmgboost(name, s):
	match name:
		b:
			return 0.25
	return 0

func check_activated(name, s):
	if s >= get_activation(name):
		return true

func on_death(who : guy, s):
	if who.mactive:
		match who.mega:
			o:
				stats.add_stats("xp", 4000)
			h:
				stats.add_stats("g", you.bounty)
	who.mactive = false

#get what streak the mega activates
func get_activation(name):
	match name:
		o:
			return 10
		b:
			return 20
		h:
			return 20

#make strings for labels in runstats
func make_stats():
	var text = []
	var m = you.mega
	var s = you.streak
	
#	string megastreak name
	var m1 = m
	m1 = m1.capitalize()
	if not megastreak_handler.check_activated(m, s):
		m1 += " - not active ("
		m1 += str(s) + "/"
		m1 += str(megastreak_handler.get_activation(m)) + ")"
	text.append(m1)
	
#	strings mega buffs/debuffs
	if megastreak_handler.check_activated(m, s):
		var stats = get_all(g, s)
		var count = 0
		for e in stats:
			if e > 0:
				var t #text
				match count:
					0:
						t = "Extra true dmg taken: "
					1:
						t = "Extra dmg taken: "
					2:
						t = "Gold Boost: "
						e = str(100*e) + "%"
					3:
						t = "XP Boost: "
						e = str(100*e) + "%"
					4:
						t = "Extra Dmg: "
						e = str(100*e) + "%"
				t += str(e)
				text.append(t)
			count += 1
	return text

#varying dmg boost (e.g. highlander doing extra dmg to bountied)
func get_var_dmg(a : guy, b : guy, d):
	match a.mega:
		h:
			if b.bounty > 0:
				d += 0.33
	return d

func get_maxbounty(a : guy):
	match a.mega:
		h:
			return 10000
	return 5000
