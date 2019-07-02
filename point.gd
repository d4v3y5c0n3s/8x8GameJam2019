extends Area2D

var agents_touching_point = []#  an array that stores all agents touching the point
var accessible = true

func is_accessible():
	return accessible

#  related to the accessibility of this point
func _on_point_body_entered(body):
	#  when a body has entered, you know that it is the map
	accessible = false
	$dummy.show()

#  related to enemies detecting agents
func _on_point_area_entered(area):
	agents_touching_point.append(area)
func _on_point_area_exited(area):
	for a in agents_touching_point:
		if area == a:
			agents_touching_point.erase(a)
