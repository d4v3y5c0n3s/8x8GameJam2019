extends Area2D

const WALK_SPEED = 0.1

onready var tween_node = $twn#  reference to the tween node

var direction = 1#  used to determine movement, 0 = left, 1 = up, 2 = right, 3 = down
var abilities = 0#  0 = no abilities, 1 = purple disguise, 2 = green disguise, 3 = body bag
var alive = true#  used to control logic related to an agent getting killed
var at_point = false#  used to trigger logic related to to arriving at points
var starting_point = Vector2()#  this and end_point are used to move and determine
var end_point = Vector2()#  when the agent needs to check if it should change direction
var finished_spawn = false
var previous_end_point = Vector2()

func _ready():
	set_process(false)
	$twn.connect("tween_completed", self, "twn_finished")

#  used for finding an initial point when the agent is placed
func _on_agent_area_entered(area):
	if not finished_spawn and area.get_parent().get_name() == "grid":
		at_point = true
		finished_spawn = true
		self.set_position(area.get_position())
		set_process(true)

#  used to ensure that the tween brings the agent to exactly where it need to be
func twn_finished(obj, np_key):
	set_position(end_point)
	at_point = true
	
func move(target_point, output=null): # sets end_point for the agents (used in _process)
	if output != null:
		print(output)
	end_point = target_point.get_position()
	starting_point = self.get_position()
	at_point = false

func _process(delta):
	#  for debugging purposes
	if previous_end_point != end_point:
		previous_end_point = end_point
		print(end_point)
	match at_point:
		true:#  agent is at point, start moving towards another point
			for n in get_parent().get_parent().get_children():
				if n.get_name() == "grid":#  gets the level's grid node
					var nearby = n.check_nearby(self.get_position())#  get the 8 surrounding points from the grid (by calling check_nearby(point))
					match direction:
						0: # left
							#  check which of the area2ds are open, ordered by which direction they first prioritize in order to determine which direction to begin moving in, then set end_point
							
								
							if not nearby[1] == null and nearby[1].is_accessible():#  top center
								direction = 1
								move(nearby[1], "going top center")
								
								
							elif not nearby[3] == null and nearby[3].is_accessible():#  left
								direction = 0
								move(nearby[3], "going left")
								
							elif not nearby[6] == null and nearby[6].is_accessible():#  bottom center, aka, they turn around
								direction = 3
								move(nearby[6], "going backwards")
								
							elif not nearby[4] == null and nearby[4].is_accessible():#  right
								direction = 2
								move(nearby[4], "going right")
							break
						1: # up
							#  check which of the area2ds are open, ordered by which direction they first prioritize in order to determine which direction to begin moving in, then set end_point
							if not nearby[4] == null and nearby[4].is_accessible():#  right
								direction = 2
								move(nearby[4], "going right")
								
							elif not nearby[1] == null and nearby[1].is_accessible():#  top center
								direction = 1
								move(nearby[1], "going top center")
								
								
							elif not nearby[3] == null and nearby[3].is_accessible():#  left
								direction = 0
								move(nearby[3], "going left")
								
							elif not nearby[6] == null and nearby[6].is_accessible():#  bottom center, aka, they turn around
								direction = 3
								move(nearby[6], "going backwards")
							break
						2: # right
							#  check which of the area2ds are open, ordered by which direction they first prioritize in order to determine which direction to begin moving in, then set end_point
							if not nearby[6] == null and nearby[6].is_accessible():#  bottom center, aka, they turn around
								direction = 3
								move(nearby[6], "going backwards")
							
							elif not nearby[4] == null and nearby[4].is_accessible():#  right
								direction = 2
								move(nearby[4], "going right")
								
							elif not nearby[1] == null and nearby[1].is_accessible():#  top center
								direction = 1
								move(nearby[1], "going top center")
								
								
							elif not nearby[3] == null and nearby[3].is_accessible():#  left
								direction = 0
								move(nearby[3], "going left")
							break
						3: # down
							#  check which of the area2ds are open, ordered by which direction they first prioritize in order to determine which direction to begin moving in, then set end_point
							if not nearby[3] == null and nearby[3].is_accessible():#  left
								direction = 0
								move(nearby[3], "going left")
								
							elif not nearby[6] == null and nearby[6].is_accessible():#  bottom center, aka, they turn around
								direction = 3
								move(nearby[6], "going backwards")
							
							elif not nearby[4] == null and nearby[4].is_accessible():#  right
								direction = 2
								move(nearby[4], "going right")
								
							elif not nearby[1] == null and nearby[1].is_accessible():#  top center
								direction = 1
								move(nearby[1], "going top center")
							break
		false:#  agent hasn't arrived at a point yet, continue moving towards it
			tween_node.interpolate_property(self, "position", starting_point, end_point, WALK_SPEED, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween_node.start()
