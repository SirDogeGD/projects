extends Node
class_name mega_data
#stores data of each megastreak

#static
var m_id := "OVRDRV"
var m_name := "Overdrive"
var unl_pres := 0
var unl_cost := 0 #renown
var buy_cost := 0 #gold
var activate_at := 20 #killstreak

#dmg
var base := 0.0
var mult := 0.0
var cc := 0.0
var cd := 0.0
var def := 0.0
var tru := 0.0
var true_def := 0.0

func update_data():
	print("update data")
