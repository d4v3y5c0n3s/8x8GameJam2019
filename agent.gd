extends Area2D

const WALK_SPEED = 1.0

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
			for n in get_parent().get_children():
				if n.get_name() == "grid":#  gets the level's grid node
					var nearby = n.check_nearby(self.position)#  get the 8 surrounding points from the grid (by calling check_nearby(point))
					#  check which of the area2ds are open
					if nearby[]:
						
					elif nearby[]:
						
					elif nearby[]:
						
					elif nearby[]:
						
					break
			
			#  determine which direction to begin moving in, set end_point
			starting_point = self.position
			at_point = false
		false:#  agent hasn't arrived at a point yet, continue moving towards it
			#  check if the agent is at a point, if so, set at_point = true
			if not self.position == end_point:
				at_point = true
			else:
				#  otherwise, continue moving towards the already chosen point
				tween_node.interpolate_property(self, "transform/position", starting_point, end_point, WALK_SPEED, Tween.TRANS_LINEAR, Tween.EASE_IN)
