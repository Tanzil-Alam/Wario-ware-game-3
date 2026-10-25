extends Node

var minigames_done = 0
var lives = 5
var brightness_value: float = 1.0
var brightness_overlay: ColorRect
var canvas_layer: CanvasLayer

var minigame_list = [
	"res://Scenes/minigame_1.tscn",
	"res://Scenes/minigame_2.tscn",
	"res://ninja_run.tscn",
	"res://minigame_4.tscn"
]

func _ready():
	canvas_layer = CanvasLayer.new()
	canvas_layer.layer = 100
	add_child(canvas_layer)

	brightness_overlay = ColorRect.new()
	brightness_overlay.color = Color(0, 0, 0, 0)
	brightness_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	brightness_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas_layer.add_child(brightness_overlay)

func update_brightness(value: float):
	brightness_value = value
	var alpha = (1.0 - value) * 0.8
	brightness_overlay.color.a = alpha

func load_next_minigame():
	if minigames_done < minigame_list.size():
		var next_scene = minigame_list[minigames_done]
		get_tree().change_scene_to_file(next_scene)
	else:
		get_tree().change_scene_to_file("res://Scenes/done_screen.tscn")
