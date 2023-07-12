extends Node2D
class_name person_timers

func add_timer(id : String):
	var timer := Timer.new()
	timer.name = "timer_" + id
	timer.wait_time = PINFO.timer_perks(id)
	%Timers.add_child(timer)

func get_timer(id : String) -> Timer:
	var timer := %Timers.get_node_or_null("timer_" + id)
	return timer

func remove_timer(id : String):
	var timer_to_remove := get_node_or_null("Timers/perk_" + id)
	if timer_to_remove != null:
		remove_child(timer_to_remove)
