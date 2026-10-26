extends Node2D

const STAR_SCENE := preload("res://Scenes/falling_star.tscn")
const GAME_DURATION := 10.0

@onready var player: CharacterBody2D = $Player
@onready var themed_timer: Node2D = get_node_or_null("ThemedTimer")

var random := RandomNumberGenerator.new()
var spawn_time_left := 0.0
var scene_transition_started := false

func _ready() -> void:
	random.randomize()

	for i in range(4):
		var star_y := -80.0 - i * 150.0
		_spawn_star(random.randf_range(35.0, 1117.0), star_y)

	spawn_time_left = 0.8
	if themed_timer == null:
		themed_timer = get_node_or_null("TimerScene")
	if themed_timer == null:
		push_error("Minigame 4 requires its themed timer scene.")
		return

	await themed_timer.Timer(GAME_DURATION)
	_win_game()

func _process(delta: float) -> void:
	if scene_transition_started:
		return

	spawn_time_left -= delta
	if spawn_time_left <= 0.0:
		_spawn_star(random.randf_range(35.0, 1117.0), -50.0)
		spawn_time_left = random.randf_range(0.65, 1.0)

func _spawn_star(x_position: float, y_position: float) -> void:
	var star := STAR_SCENE.instantiate() as Area2D
	star.position = Vector2(x_position, y_position)
	star.set("fall_speed", random.randf_range(230.0, 330.0))
	star.body_entered.connect(_on_star_body_entered)
	add_child(star)

func _on_star_body_entered(body: Node2D) -> void:
	if scene_transition_started or body != player:
		return

	scene_transition_started = true
	Global.lose_life()

func _win_game() -> void:
	if scene_transition_started:
		return

	scene_transition_started = true
	Global.minigames_done += 1
	get_tree().change_scene_to_file("res://Scenes/done_screen.tscn")
