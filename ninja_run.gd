extends Node2D

@onready var themed_timer: Node2D = get_node_or_null("ThemedTimer")

var scene_transition_started := false

func _ready() -> void:
	if themed_timer == null:
		themed_timer = get_node_or_null("TimerScene")

	if themed_timer == null:
		push_error("Ninja Run needs a ThemedTimer or TimerScene child.")
		return

	await themed_timer.Timer(10.0)
	_on_game_win()

func _on_game_win() -> void:
	if scene_transition_started:
		return

	scene_transition_started = true
	Global.minigames_done += 1
	get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")

func _on_game_over() -> void:
	if scene_transition_started:
		return

	scene_transition_started = true
	Global.lives = maxi(Global.lives - 1, 0)
	get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")
