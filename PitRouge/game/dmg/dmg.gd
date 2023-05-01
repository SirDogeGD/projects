extends Node

func calc(a : person, b : person):
	
	var dmg := a.selected_item.damage
	var ap := a.perks
	var ae := a.effects
	var bp := b.perks
	var be := b.effects
	
	#BASE
	#weakness
	#megastreak b extra base dmg
	#base dmg perks
	
	#MULTIPLIER
	#multi perks
	#megastreak dmg boost
	#crit
	
	#DEFENCE
	#base def
	#perk def
	#resistance
	
	#TRUE
	#perk true
	#megastreak true
	
	#TRUE DEFENCE
	#effect true def
	#perk true def
	
	b.get_hit(a, dmg)
