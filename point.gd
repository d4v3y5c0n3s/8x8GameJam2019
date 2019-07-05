extends Area2D

var agents_touching_point = []#  an array that stores all agents touching the point
var accessible = true
var light_up = false

func _physics_process(delta):
	if light_up:
		$Sprite.show()
		light_up = false
	else:
		$Sprite.hide()

func is_accessible():
	return accessible

#  related to the accessibility of this point
func _on_point_body_entered(body):
	#  when a body has entered, you know that it is the map
	accessible = false

#  related to enemies detecting agents
func _on_point_area_entered(area):
	if area.get_parent().name == "agents":
		agents_touching_point.append(area)
func _on_point_area_exited(area):
	for a in agents_touching_point:
		if area == a:
			agents_touching_point.erase(a)
