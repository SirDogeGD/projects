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
		print(curHP, " ", guy)
		if curHP == 0 and guy != null:
			print("why not work???")
			guy.on_death()
		changed.emit()
var maxSH := 5
var curSH : float:
	set(sh):
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
