extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	pass

#func _process(delta):
#	pass

#  removes agents which leave the level
func _on_goal_area_entered(area):
	if area.get_parent().name == "agents":
		area.queue_free()#  deletes the agent
