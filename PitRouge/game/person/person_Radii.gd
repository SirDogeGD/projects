extends Node2D

#get persons in range
func gpir(id : String) -> Array[person]:
	var persons_in_range : Array[person]
	var area := get_node_or_null("Radii/perk_" + id)
	if area != null:
		for body in area.get_overlapping_bodies(): #get persons in range
			if body != self and body is person:
				persons_in_range.append(body)	
	return persons_in_range

func add_radius(id : String, r := 10):
	r *= 100 #1 block = 100 pixels
	
	var area := Area2D.new() #create area2d
	area.name = "perk_" + id
	add_child(area)
	
	var col := CollisionShape2D.new() #create shape
	var shape = CircleShape2D.new()
	shape.radius = r
	col.shape = shape
	area.add_child(col)

func remove_radius(id : String):
	var radius_to_remove := get_node_or_null("perk_" + id)
	if radius_to_remove != null:
		remove_child(radius_to_remove)
		radius_to_remove.queue_free()

func remove_all():
	for e in get_children():
		remove_child(e)
		e.queue_free()
