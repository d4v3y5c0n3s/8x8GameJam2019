extends Area2D

const WALK_SPEED = 1

onready var tween_node = $twn#  reference to the tween node

var direction = 1#  used to determine movement, 0 = left, 1 = up, 2 = right, 3 = down
var abilities = 0#  0 = no abilities, 1 = purple disguise, 2 = green disguise, 3 = body bag
var alive = true#  used to control logic related to an agent getting killed
var at_point = false#  used to trigger logic related to to arriving at points
var starting_point = Vector2()#  this and end_point are used to move and determine
var end_point = Vector2()#  when the agent needs to check if it should change direction

func _ready():
	pass

func _process(delta):
	match at_point:
		true:#  agent is at point, start moving towards another point
			pass
		false:#  agent hasn't arrived at a point yet, continue moving towards it
			pass
