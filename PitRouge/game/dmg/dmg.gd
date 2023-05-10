extends Node

func calc(a : person, b : person):
	
	var dmg := a.selected_item.damage
	var ap := a.perks
	var ae := a.effect_node
	var bp := b.perks
	var be := b.effect_node
	
	#BASE
	var base = dmg
	#weakness
	#megastreak b extra base dmg
	#base dmg perks
	base += PERKS.calc("base_dmg", a, b)
	
	#MULTIPLIER
	var mult = 1
	#strength
	mult += ae.get_boost("STRENGTH")
	#multi perks
	mult += PERKS.calc("mult_dmg", a, b)
	#megastreak dmg boost
	#crit
	
	#DEFENCE
	var def = 0.8 #20% def by default
	#base def
	def *= 1 - PERKS.calc("base_def", a, b)
	#perk def
	#resistance
	
	#TRUE
	#perk true
	#megastreak true
	
	#TRUE DEFENCE
	#effect true def
	#perk true def
	
	dmg = base * mult * def
	print(dmg)
	b.get_hit(a, dmg)
