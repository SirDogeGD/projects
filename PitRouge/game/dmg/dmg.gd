extends Node

func calc(a : person, b : person) -> dmg_data:
	
	var dmg := a.selected_item.damage
#	var ap := a.perks
	var ae := a.effect_node
#	var bp := b.perks
	var be := b.effect_node
	var am := a.mega_stats 
	var bm := b.mega_stats
	
	#BASE
	var base := dmg
	#weakness
	#megastreak extra base dmg
	base += am.base + bm.base_taken
	#base dmg perks
	base += PERKS.calc("base_dmg", a, b)
	
	#MULTIPLIER
	var mult := 1.0
	#strength
	mult += ae.get_boost("STRENGTH")
	#multi perks
	mult += 1 - PERKS.calc("mult_dmg", a, b)
	#megastreak dmg boost
	mult += am.mult
	if b.bounty > 0:
		mult += am.vs_bounty
	if b.stats.prestige == 0:
		mult += am.vs_pres_0
	
	#CRIT CHANCE
	var crit := false
	var cc := 5.0
	#cc perks
	cc += PERKS.calc("cc", a, b)
	#megastreak cc
	cc += am.cc
	
	if randf() <= cc / 100:
		crit = true
	
	#CRIT DAMAGE
	var cd := 1.5
	#megastreak cd
	cd += am.cd
	
	if crit:
		dmg *= cd
	
	#DEFENCE
	var def := 0.7 #30% def by default
	#base def
	def *= 1 - PERKS.calc("base_def", a, b)
	#perk def
	#resistance
	def *= ae.get_boost("RES")
	#blocking
	if b.item_slow and b.inv.get_selected() is sword:
		def *= 0.5
	
	#TRUE
	#true dmg of attacker + true dmg of defender
	var tru := 0.0
	#perk true
	#megastreak true
	tru += am.tru + bm.tru_taken
	
	#TRUE DEFENCE (Subtracts from true dmg)
	var tru_def := 0.0
	#effect true def
	#perk true def
	#megastreak true def
	tru_def += bm.tru_def
	
	#Calculate
	var d = dmg_data.new()
	d.amount = base * mult * def
	d.trudmg = tru - tru_def
	d.crit = crit
	d.attacker = a
	d.defender = b
	return d
