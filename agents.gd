extends Node2D

onready var agent = preload("res://agent.tscn")
var spawn_rate = 1.0
var delta_time = 0.0

func _ready():
	pass

func _process(delta):
	if delta_time >= spawn_rate:#  when delta time adds up to the spawn_rate (1.0 = 1 second), spawns another agent
		delta_time = delta
		print("!")
		
		#  spawn an enemy here
		var agent_inst = agent.instance()
		add_child(agent_inst)
		for i in get_parent().get_children():
			if i.name == "agent_spawnpoint":
				agent_inst.set_position(i.get_position())
				agent_inst.starting_point = i.get_position()
				agent_inst.end_point = i.get_position()
				break
		
	else:
		delta_time += delta
