extends Control

var chat = ["", "", "", ""]

func make_chat():
	return(chat[0] + "\n" + chat[1] + "\n" + chat[2] + "\n" + chat[3])

func add(line):
	if chat.has(""):
		chat[chat.find("")] = line
	else:
		chat[0] = chat[1]
		chat[1] = chat[2]
		chat[2] = chat[3]
		chat[3] = line
	
	get_tree().call_group("chat", "update_label")

func kill_msg(arr):
	add("Kill! you earned " + String(arr[0]) + " xp and " + String(arr[1]) + " gold")

func mega(name):
	match name:
		"overdrive":
			add("Overdrive Activated!")
		"beastmode":
			add("Beastmode on!")

func clear():
	chat = ["", "", "", ""]

func contract_comp(gold):
	add(str("Contract completed! +", gold, "g"))

func won_event(which):
	match which:
		"math":
			add("Correct! +250xp +500g")
