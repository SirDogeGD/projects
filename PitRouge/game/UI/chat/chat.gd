extends Node

var texts : Array[String]

func add(t : String):
	texts.append(t)
	
	if len(texts) > 100:
		texts.remove_at(0)
