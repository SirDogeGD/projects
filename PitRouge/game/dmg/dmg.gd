extends Node

func calc(a : person, b : person) -> dmg_data:
	
	var dmg := a.selected_item.damage
	var ap := a.perks
	var ae := a.effect_node
	var bp := b.perks
	var be := b.effect_node
	
	#BASE
	var base := dmg
	#weakness
	#megastreak b extra base dmg
	#base dmg perks
	base += PERKS.calc("base_dmg", a, b)
	
	#MULTIPLIER
	var mult := 1.0
	#strength
	mult += ae.get_boost("STRENGTH")
	#multi perks
	mult += PERKS.calc("mult_dmg", a, b)
	#megastreak dmg boost
	
	#CRIT CHANCE
	var crit := false
	var cc := 5.0
	if randf() <= cc / 100:
		crit = true
	
	#CRIT DAMAGE
	var cd := 1.5
	
	if crit:
		dmg *= cd
	
	#DEFENCE
	var def := 0.7 #30% def by default
	#base def
	def *= 1 - PERKS.calc("base_def", a, b)
	#perk def
	#resistance
	
	#TRUE
	var tru := 0.0
	#perk true
	#megastreak true
	
	#TRUE DEFENCE
	#effect true def
	#perk true def
	
	#Calculate
	var d = dmg_data.new()
	d.amount = base * mult * def
	d.trudmg = tru
	d.crit = crit
	return d
