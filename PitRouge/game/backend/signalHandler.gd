extends Node

signal listen(id : String, data)

func speak(id : String, data = null):
	listen.emit(id, data)
