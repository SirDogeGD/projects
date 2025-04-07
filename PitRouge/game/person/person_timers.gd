extends Node2D
class_name person_timers

#add perk timer
func add_timer(id : String):
	var timer := Timer.new()
	timer.name = "timer_" + id
	timer.wait_time = PINFO.timer_perks(id)
	timer.one_shot = false
	timer.autostart = true
	%Timers.add_child(timer)
	timer.timeout.connect(PERKS.on_timer_timeout.bind(owner, id))

func get_timer(id : String) -> Timer:
	var timer := %Timers.get_node_or_null("timer_" + id)
	return timer

func remove_timer(id : String):
	var timer_to_remove := get_node_or_null("Timers/timer_" + id)
	if timer_to_remove != null:
		remove_child(timer_to_remove)

func remove_all_timers():
	for t in get_children():
		if t.name.begins_with("timer_"):
			remove_child(t)
