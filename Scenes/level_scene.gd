extends Node2D

@onready var garlic_container: HBoxContainer = $GarlicContainer
@onready var garlic: TextureRect = $GarlicContainer/Garlic
@onready var garlic_2: TextureRect = $GarlicContainer/Garlic2
@onready var garlic_3: TextureRect = $GarlicContainer/Garlic3
@onready var garlic_4: TextureRect = $GarlicContainer/Garlic4
@onready var garlic_5: TextureRect = $GarlicContainer/Garlic5

@onready var level: RichTextLabel = $Level
@onready var timer: RichTextLabel = $Timer

var time: float = 0.0
var scene_transition_started := false

func _ready() -> void:
	if Global.lives <= 0:
		_show_death_screen()
		return

	await Timer(5.0)
	if not scene_transition_started:
		Global.load_next_minigame()

func _process(delta: float) -> void:
	if Global.lives <= 0:
		_show_death_screen()
		return

	for i in range(5 - Global.lives):
		garlic_container.get_child(i).hide()
	
	timer.text = str(snapped(time, 0.1))
	level.text = "Level " + str(Global.minigames_done + 1)

func _show_death_screen() -> void:
	if scene_transition_started:
		return

	scene_transition_started = true
	garlic_container.hide()
	get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")

func Timer(start_time: float) -> void:
	time = start_time
	while time > 0.0:
		await wait(0.1)
		time -= 0.1
		if time < 0.0:
			time = 0.0

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
