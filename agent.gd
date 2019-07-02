extends Area2D

const WALK_SPEED = 1.0

onready var tween_node = $twn#  reference to the tween node

var direction = 1#  used to determine movement, 0 = left, 1 = up, 2 = right, 3 = down
var abilities = 0#  0 = no abilities, 1 = purple disguise, 2 = green disguise, 3 = body bag
var alive = true#  used to control logic related to an agent getting killed
var at_point = false#  used to trigger logic related to to arriving at points
var starting_point = Vector2()#  this and end_point are used to move and determine
var end_point = Vector2()#  when the agent needs to check if it should change direction
var finished_spawn = false

func _ready():
	set_process(false)
	#  sets up agent when spawned
	print("ready called in agent")
	
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

func _process(delta):
	match at_point:
		true:#  agent is at point, start moving towards another point
			for n in get_parent().get_parent().get_children():
				print(n.get_name())
				if n.get_name() == "grid":#  gets the level's grid node
					var nearby = n.check_nearby(self.position)#  get the 8 surrounding points from the grid (by calling check_nearby(point))
					
					#  check which of the area2ds are open, ordered by which direction they first prioritize in order to determine which direction to begin moving in, then set end_point
					if nearby[4].inaccessible:#  right
						end_point = nearby[4].get_position()
					elif nearby[1].inaccessible:#  top center
						end_point = nearby[1].get_position()
					elif nearby[3].inaccessible:#  left
						end_point = nearby[3].get_position()
					else:#  bottom center, aka, they turn around
						end_point = nearby[6].get_position()
					break
			starting_point = self.get_position()
			at_point = false
		false:#  agent hasn't arrived at a point yet, continue moving towards it
			
			tween_node.interpolate_property(self, "position", starting_point, end_point, WALK_SPEED, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween_node.start()
			print(self.get_position())
