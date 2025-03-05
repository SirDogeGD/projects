extends Node
class_name mega

#will need "on_activate" and "on_death"
#for visuals, adding permanent potion effects and overdrive xp/highlander bounty

static func get_mega_data(m : mega_data):
	
	match m.m_id:
		"OVRDRV":
			m.m_name = "Overdrive"
			m.unl_pres = 0
			m.unl_cost = 0
			m.buy_cost = 0
			m.activate_at = 10

		"BEAST":
			m.m_name = "Beastmode"
			m.unl_pres = 1
			m.unl_cost = 10
			m.buy_cost = 10000
			m.activate_at = 20

		"HERMIT":
			m.m_name = "Hermit"
			m.unl_pres = 2
			m.unl_cost = 20
			m.buy_cost = 15000
			m.activate_at = 30

		"HIGH":
			m.m_name = "Highlander"
			m.unl_pres = 5
			m.unl_cost = 25
			m.buy_cost = 30000
			m.activate_at = 50

		"OPUS":
			m.m_name = "Magnum Opus"
			m.unl_pres = 18
			m.unl_cost = 50
			m.buy_cost = 60000
			m.activate_at = 50

		"MOON":
			m.m_name = "To the Moon"
			m.unl_pres = 20
			m.unl_cost = 70
			m.buy_cost = 80000
			m.activate_at = 100

		"UBER":
			m.m_name = "Uberstreak"
			m.unl_pres = 25
			m.unl_cost = 100
			m.buy_cost = 100000
			m.activate_at = 100

static func get_streak_data(m : mega_data, s := 0.0):
	
	m.reset_streak_data()
	
	if not m.active:
		m.active = check_active(m.activate_at, s)
	
	match m.m_id:
		"OVRDRV":
			if m.active:
				m.tru_taken = ((int(s) - m.activate_at) / 5) / 10.0
				m.gboost = 0.5
				m.xpboost = 1
				if not m.guy.effect_node.get_children().any(func(e): return e.from == "OVRDRV"):
					m.guy.effect_node.add_effect("SPEED", 0, "OVRDRV")
				#missing 4k death xp

		"BEAST":
			if m.active:
				m.mult = 0.25
				m.base_taken = ((int(s) - m.activate_at) / 5) / 10.0 
				m.gboost = 0.75
				m.xpboost = 0.5
				#missing dia helm

		"HERMIT":
			if m.active:
				m.tru_def = 999
				m.mult_taken = (int(s) - m.activate_at) * 0.03
				m.gboost = min((int(s) - m.activate_at) * 0.05 + 0.05, 0.75) #maximum 75% gold and xp
				m.xpboost = min((int(s) - m.activate_at) * 0.05 + 0.05, 0.75)
				#missing slowness + resistance + bedrock?

		"HIGH":
			if m.active:
				m.gboost = 1.1
				m.vs_bounty = 0.333
				#missing death gold + speed

		"OPUS":
			if m.active:
				if m.guy != null:
					m.guy.stats.renown += 1
					m.guy.on_death()

		"MOON":
			if m.active:
				m.xpboost = 0.2
				m.mult_taken = (int(s) - m.activate_at) * 0.005
				m.tru_taken = (max(0, int(s) - m.activate_at + 100)) * 0.005
				m.moon_xp_mult = min(1, (int(s) - m.activate_at) * 0.005) #max 1x
				#missing xp storage

		"UBER":
			if m.active:
				m.mult_taken = int(s) * 0.001
				m.vs_pres_0 = 0.4
				if s >= 200:
					m.max_hp = 4
					if s >= 300:
						m.effect_dura = 0.5
						if s >= 400:
							if m.guy != null:
								m.guy.on_death()
								#missing uberdrop

static func check_active(at : int, s := 0.0) -> bool:
	if s >= at:
		return true
	return false
