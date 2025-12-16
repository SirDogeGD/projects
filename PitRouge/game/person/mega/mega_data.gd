extends Node
class_name mega_data
#stores data of each megastreak

signal mega_activated(id : String)

var guy : person

#MEGA DATA - get_mega_data(self)
var m_id := "OVRDRV"
var m_name := "Overdrive"
var unl_pres := 0
var unl_cost := 0 #renown
var buy_cost := 0 #gold
var activate_at := 20 #killstreak

#STREAK DATA - get_streak_data(self)
var active := false:
	set(state):
		if state == true:
			mega_activated.emit(m_id)
#dmg
var base := 0.0
var mult := 0.0
var cc := 0.0
var cd := 0.0
var def := 0.0
var tru := 0.0
var base_taken := 0.0
var mult_taken := 0.0
var tru_taken := 0.0
var tru_def := 0.0
#resources
var g_on_kill := 0.0
var xp_on_kill := 0.0
var gboost := 0.0
var xpboost := 0.0
#more specific
var vs_bounty := 0.0
var moon_stored_xp := 0.0
var moon_xp_mult := 0.0
var vs_pres_0 := 0.0
var max_hp := 0 #needs signal or something
var effect_dura := 5.0

func refresh():
	mega.get_mega_data(self)
	mega.get_streak_data(self)
	mega.on_spawn(self)

func update_data(s := 0.0):
	mega.get_streak_data(self, s)

func reset_streak_data():
	base = 0.0
	mult = 0.0
	cc = 0.0
	cd = 0.0
	def = 0.0
	tru = 0.0
	#taken
	base_taken = 0.0
	mult_taken = 0.0
	tru_taken = 0.0
	tru_def = 0.0
	#resources
	g_on_kill = 0.0
	xp_on_kill = 0.0
	gboost = 0.0
	xpboost = 0.0
	#more specific
	vs_bounty = 0.0
	moon_stored_xp = 0.0
	moon_xp_mult = 0.0
	vs_pres_0 = 0.0
	max_hp = 0
	effect_dura = 1.0

func mega_on_death():
	mega.on_death(self)
