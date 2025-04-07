extends Node
class_name hp_data

signal changed

var guy : person
var maxHP := 20:
	set(hp):
		maxHP = hp
		changed.emit()
var curHP : float = maxHP:
	set(hp):
		curHP = clamp(hp, 0, maxHP)
		if curHP == 0 and guy != null:
			guy.on_death()
		changed.emit()
var maxSH := 6
var curSH : float:
	set(sh):
		calc_maxSH()
		curSH = clamp(sh, 0, maxSH)
		changed.emit()

func reset():
	maxHP = 20
	curHP = maxHP
	maxSH = 5
	curSH = 0

func take_dmg(d : dmg_data):
	if d.amount <= curSH: #hit does less damage than the amount of shield left
		curSH -= d.amount
	else:
		var new_amount = d.amount - curSH #normal case, new_amount because of dmg_taken
		curSH = 0
		curHP -= new_amount
	curHP -= d.trudmg

func calc_maxSH():
	maxSH = 6 + PERKS.get_bonus_maxsh(guy)
