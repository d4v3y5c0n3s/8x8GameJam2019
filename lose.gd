extends Panel

func _on_Button_pressed():
	#  reset the current level
	get_tree().reload_current_scene()
