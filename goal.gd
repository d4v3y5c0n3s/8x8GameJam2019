extends Area2D

func _ready():
	pass

#  removes agents which leave the level
func _on_goal_area_entered(area):
	if area.get_parent().name == "agents":
		area.queue_free()#  deletes the agent
		
		#  makes the player win
		area.get_parent().game_win = true
