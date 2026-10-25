extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer 

var garlic_collected = 0 
var timer_end = false 
var scene_transition_started = false

func _ready() -> void:
	await themed_timer.Timer(10.0) 
	timer_end = true 

func _process(delta: float) -> void: 
	if scene_transition_started:
		return

	if garlic_collected >= 2:
		scene_transition_started = true
		Global.minigames_done = 1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")
	elif timer_end:
		scene_transition_started = true
		Global.lives -= 1 
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")

func garlic_collect() -> void: 
	garlic_collected = garlic_collected + 1
	return
