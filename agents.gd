extends Node2D

onready var agent = preload("res://agent.tscn")
#var spawn_rate = 1.0
#var delta_time = 0.0
#var selected_agent = null#  the agent which will receive the abilities on use
var game_lose = false
var game_win = false

func _ready():
	pass

func _process(delta):
	
	if game_lose:
		for i in get_parent().get_children():
			if i.name == "lose":
				i.show()
	if game_win:
		for i in get_parent().get_children():
			if i.name == "win":
				i.show()
	
	#  get player input and handle it appropriately
	if Input.is_action_just_pressed("ui_select") and not game_lose and not game_win:
		#  spawn an enemy here
		var agent_inst = agent.instance()
		add_child(agent_inst)
		for i in get_parent().get_children():
			if i.name == "agent_spawnpoint":
				agent_inst.set_position(i.get_position())
				agent_inst.starting_point = i.get_position()
				agent_inst.end_point = i.get_position()
				break
