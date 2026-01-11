extends Node

var texts : Array[String]

func add_to_texts(t : String):
	texts.append(t)
	
	if len(texts) > 100:
		texts.remove_at(0)


func add(type : String, meta = 0):
	
	var t : String
	
	match type:
#Kill
		"K":
			if meta is rewards_data:
				t = "[color=" + Constants.COLOR_RED + "]KILL![/color] +%sxp +%sg"
				t = Constants.repl(t) % [meta.xp, meta.gold]
#Assist
		"A":
			if meta is rewards_data:
				t = "[color=" + Constants.COLOR_RED + "]Assist![/color] +%sxp +%sgold"
				t = Constants.repl(t) % [meta.xp, meta.gold]
#Streak
		"S":
			if meta is streak_data:
				t = "[color=" + Constants.COLOR_RED + "]STREAK![/color] of %s kills by %s"
				t = Constants.repl(t) % [meta.streak, meta.p.get_fancy_name()]
#Megastreak
		"S":
			if meta is mega_data:
				t = "[color=" + Constants.COLOR_RED + "]MEGASTREAK![/color] %s activated %s"
				t = Constants.repl(t) % [meta.guy.get_fancy_name(), meta.m_name]
#Bounty Bump
		"BB":
			pass
#Bounty Claimed
		"BC":
			pass
#Events
		"E":
			pass
#Contracts
		"C":
			pass
#Night Quest
		"NQ":
			pass
#Free XP
		"FXP":
			pass
		_:
			pass
	
	print(t)
	add_to_texts(t)
