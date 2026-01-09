extends Node

var C := Constants.new()
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
				t = "Kill! +%sxp +%sgold"
				t = C.repl(t) % [meta.xp, meta.gold]
#Assist
		"A":
			if meta is rewards_data:
				t = "Assist! +%sxp +%sgold"
				t = C.repl(t) % [meta.xp, meta.gold]
#Streak
		"S":
			if meta is float:
				t = "STREAK! of %s kills by %s"
				t = C.repl(t) % [meta]
#Megastreak
		"S":
			if meta is mega_data:
				t = "MEGASTREAK! %s activated %s"
				t = C.repl(t) % [meta.guy.person_name, meta.m_name]
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
	
	add_to_texts(t)
