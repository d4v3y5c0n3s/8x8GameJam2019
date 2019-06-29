extends Node2D

var mouse_on_level_1 = false
var mouse_on_level_2 = false
var mouse_on_level_3 = false
var mouse_on_level_4 = false
var mouse_on_level_5 = false

func _ready():
	# this code connects the "mouse_entered" & "mouse_exited" signals to the mouse_on_level variable (meaning the var will be false when not on something clickable and true when it is)
	#  level 1
	$level_1.connect("mouse_entered", self, "_mouse_on_level_1", [true])
	$level_1.connect("mouse_exited", self, "_mouse_on_level_1", [false])
	
	#  level 2
	$level_2.connect("mouse_entered", self, "_mouse_on_level_2", [true])
	$level_2.connect("mouse_exited", self, "_mouse_on_level_2", [false])
	
	#  level 3
	$level_3.connect("mouse_entered", self, "_mouse_on_level_3", [true])
	$level_3.connect("mouse_exited", self, "_mouse_on_level_3", [false])
	
	#  level 4
	$level_4.connect("mouse_entered", self, "_mouse_on_level_4", [true])
	$level_4.connect("mouse_exited", self, "_mouse_on_level_4", [false])
	
	#  level 5
	$level_5.connect("mouse_entered", self, "_mouse_on_level_5", [true])
	$level_5.connect("mouse_exited", self, "_mouse_on_level_5", [false])

#funcs for setting the values of which item the mouse is over
func _mouse_on_level_1(over):
	mouse_on_level_1 = over
func _mouse_on_level_2(over):
	mouse_on_level_2 = over
func _mouse_on_level_3(over):
	mouse_on_level_3 = over
func _mouse_on_level_4(over):
	mouse_on_level_4 = over
func _mouse_on_level_5(over):
	mouse_on_level_5 = over

func _unhandled_input(event):#  unhandled input allows us to set input as "handled," so that we don't click multiple things at once
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():#  if mouse is over level and the left mouse button is being pressed
		#  checks if the mouse is over any of the levels, and changes to the appropriate scene
		if mouse_on_level_1:
			get_tree().change_scene("res://level_1.tscn")
		elif mouse_on_level_2:
			get_tree().change_scene("res://level_2.tscn")
		elif mouse_on_level_3:
			get_tree().change_scene("res://level_3.tscn")
		elif mouse_on_level_4:
			get_tree().change_scene("res://level_4.tscn")
		elif mouse_on_level_5:
			get_tree().change_scene("res://level_5.tscn")
		get_tree().set_input_as_handled()#  handles the input
