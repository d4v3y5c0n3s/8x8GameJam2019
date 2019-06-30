extends Area2D

var agents_touching_point = []#  an array that stores all agents touching the point

func _on_point_area_entered(area):
	agents_touching_point.append(area)

func _on_point_area_exited(area):
	for a in agents_touching_point:
		if area == a:
			agents_touching_point.erase(a)
