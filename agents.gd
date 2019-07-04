extends Node2D

var spawn_rate = 1.0
var delta_time = 0.0

func _ready():
	pass

func _process(delta):
	if delta_time >= spawn_rate:#  when delta time adds up to the spawn_rate (1.0 = 1 second), spawns another agent
		delta_time = delta
		print("!")
	else:
		delta_time += delta
