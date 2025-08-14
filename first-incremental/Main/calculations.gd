extends Node

var minions := ["Wood Minion"]

var base_vals := {
	"Wood Minion" : 0.1,
	"Better Clicks" : 0.5,
	"Better Wood Minion" : 0.1
}

#overall income
func calc_income() -> float:
	var income : float
	for m in minions:
		if GameState.upgrades.has(m):
			income += GameState.upgrades[m] * calc_Minion_cps(m)
	return income

#income of an upgrade
func calc_upgrade_income(name : String) -> float:
	var income : float
	if GameState.upgrades.has(name):
		income += GameState.upgrades[name] * calc_Minion_cps(name)
	return income

#Minion income
func calc_Minion_cps(name : String) -> float:
	var cps : float = 0.1
	if GameState.upgrades.has("Better " + name):
		cps += GameState.upgrades["Better " + name] * base_vals.get("Better " + name)
	return cps
	
#income per click
func calc_click_souls() -> float:
	var amount : float = 0
	if GameState.upgrades.has("Better Clicks"):
		amount = GameState.upgrades.get("Better Clicks") * base_vals.get("Better Clicks")
	return amount + 1
