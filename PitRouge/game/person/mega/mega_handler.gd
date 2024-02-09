extends Node
class_name mega

func get_mega_data(m : mega_data):
	
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

		"HIGH":
			m.m_name = "Highlander"
			m.unl_pres = 2
			m.unl_cost = 20
			m.buy_cost = 15000
			m.activate_at = 30

		"HERMIT":
			m.m_name = "Hermit"
			m.unl_pres = 5
			m.unl_cost = 25
			m.buy_cost = 30000
			m.activate_at = 50

		"OPUS":
			m.m_name = "Magnum Opus"
			m.unl_pres = 18
			m.unl_cost = 50
			m.buy_cost = 60000
			m.activate_at = 75

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

func get_streak_data(m : mega_data, s := 0.0):
	
	match m.m_id:
		"OVRDRV":
			if s >= m.activate_at:
				pass

		"BEAST":
			if s >= m.activate_at:
				pass

		"HIGH":
			if s >= m.activate_at:
				pass

		"HERMIT":
			if s >= m.activate_at:
				pass

		"OPUS":
			if s >= m.activate_at:
				pass

		"MOON":
			if s >= m.activate_at:
				pass

		"UBER":
			if s >= m.activate_at:
				pass
