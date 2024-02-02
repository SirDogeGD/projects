extends Node
class_name mega

func get_mega_data(id : String):
	var m := mega_data.new()
	m.m_id = id
	
	match id:
		"OVRDRV":
			m.m_name = "Overdrive"
			m.unl_pres = 0
			m.unl_cost = 0
			m.buy_cost = 0
			m.activate_at = 20
		"BEAST":
			m.m_name = "Overdrive"
			m.unl_pres = 1
			m.unl_cost = 10
			m.buy_cost = 10000
			m.activate_at = 25
		"HIGH":
			m.m_name = "Overdrive"
			m.unl_pres = 2
			m.unl_cost = 20
			m.buy_cost = 15000
			m.activate_at = 30
		"HERMIT":
			m.m_name = "Overdrive"
			m.unl_pres = 5
			m.unl_cost = 25
			m.buy_cost = 30000
			m.activate_at = 50
		"OPUS":
			m.m_name = "Overdrive"
			m.unl_pres = 18
			m.unl_cost = 50
			m.buy_cost = 60000
			m.activate_at = 75
		"MOON":
			m.m_name = "Overdrive"
			m.unl_pres = 20
			m.unl_cost = 70
			m.buy_cost = 80000
			m.activate_at = 100
		"UBER":
			m.m_name = "Overdrive"
			m.unl_pres = 25
			m.unl_cost = 100
			m.buy_cost = 100000
			m.activate_at = 100
	
	return m

