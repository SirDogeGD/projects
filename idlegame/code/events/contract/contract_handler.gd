extends Node2D

var contractFile = load("res://code/events/contract/contract.gd")

var rng = RandomNumberGenerator.new()

var active = []
var choices = ["this", "shouldn't", "appear"]

#func _ready():
#	make_choice()

func choose(num):
	active.append(choices[num])
	scene_handler.next_scene()

#make contracts that the player chooses from
func make_choice():
	choices.clear()
	rng.randomize()
	var types = ["p", "k", "b", "e"]
	types.shuffle()
	for n in 3:
		match types[n]:
			"p":
				choices.append(cont_perk())
			"k":
				choices.append(cont_kills())
			"b":
				choices.append(cont_buy())
			"e":
				choices.append(cont_event())

#make contract types
func cont_perk():
	rng.randomize()
	var new = contractFile.new()
	new.set_type("p")
	new.set_count(rng.randi_range(2,5))
#	roll a random perk by id
	var possible_perks = [1, 2, 3, 4, 5]
	var id = possible_perks[rng.randi_range(0, possible_perks.size() - 1)]
#	figure out name of perk
	var name = perk_info.perkinfo(id).get_name()
	new.set_point(id)
	return new

func cont_kills():
	rng.randomize()
	var new = contractFile.new()
	new.set_type("k")
	new.set_count(rng.randi_range(10,15))
	return new

func cont_buy():
	rng.randomize()
	var new = contractFile.new()
	new.set_type("b")
	new.set_count(1)
	var buy_perks = [6, 7, 8]
	buy_perks.shuffle()
	new.set_point(buy_perks[0])
	return new

func cont_event():
	rng.randomize()
	var new = contractFile.new()
	new.set_type("e")
	new.set_count(1)
	var events = ["quick maths"]
	events.shuffle()
	new.set_point(events[0])
	return new

#contract types progress
func perk_and_kills(perks):
	for n in active:
		if n.get_type() == "p":
			if perks.has(n.get_point()):
					n.count()
		if n.get_type() == "k":
			n.count()

func buy(bought):
	for n in active:
		if n.get_type() == "b":
			if bought == n.get_point():
				n.count()

func event(which):
	for n in active:
		if n.get_type() == "e":
			if which == n.get_point():
				n.count()

#completed contract
func complete(contract):
	var gold = make_rewards(contract)
	stats.add_stats("g", gold)
	chat.contract_comp(gold)
	active.erase(contract)

func make_rewards(contract):
	match contract.get_type():
		"p":
			return rng.randi_range(300, 500)
		"k":
			return rng.randi_range(200, 400)
		"b":
			return rng.randi_range(400, 500)
		"e":
			return rng.randi_range(500, 700)
