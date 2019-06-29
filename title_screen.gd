extends Node2D

#  when either space or enter is received, changes to the
#level select scene
func _input(event):
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://level_select.tscn")
