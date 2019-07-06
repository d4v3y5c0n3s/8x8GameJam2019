extends Node2D

onready var agent = preload("res://agent.tscn")
#var spawn_rate = 1.0
var delta_time = 0.0
var selected_agent = null#  the agent which will receive the abilities on use

func _ready():
	pass

func _process(delta):
	
	#  get player input and handle it appropriately
	if Input.is_action_just_pressed("ui_select"):
		#  spawn an enemy here
		var agent_inst = agent.instance()
		add_child(agent_inst)
		for i in get_parent().get_children():
			if i.name == "agent_spawnpoint":
				agent_inst.set_position(i.get_position())
				agent_inst.starting_point = i.get_position()
				agent_inst.end_point = i.get_position()
				break
	
	#  if an agent is selected, allow them to recieve abilities
	if selected_agent != null:
		pass
