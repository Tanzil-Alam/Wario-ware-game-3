extends Node2D

@onready var brightness_slider = $HSlider
@onready var back_button = $BackButton 

func _ready():
	brightness_slider.min_value = 0.0
	brightness_slider.max_value = 1.0
	brightness_slider.step = 0.05
	brightness_slider.value = Global.brightness_value
	Global.update_brightness(brightness_slider.value)
	
	if not brightness_slider.value_changed.is_connected(_on_brightness_changed):
		brightness_slider.value_changed.connect(_on_brightness_changed)
	
	if back_button:
		if not back_button.pressed.is_connected(_on_back_pressed):
			back_button.pressed.connect(_on_back_pressed)

func _on_brightness_changed(value: float):
	Global.update_brightness(value)

func _on_back_pressed():
	print("Back button pressed! Changing scene...") 
	var result = get_tree().change_scene_to_file("res://Scenes/title_scene.tscn")
	if result != OK:
		print("Error: Could not change scene!")
