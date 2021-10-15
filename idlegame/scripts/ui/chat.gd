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

func kill_msg(arr):
	add("Kill! you earned " + String(arr[0]) + " xp and " + String(arr[1]) + " gold")

func mega(name):
	match name:
		"od":
			add("Overdrive Activated!")

func clear():
	chat = ["", "", "", ""]
