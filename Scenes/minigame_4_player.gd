extends CharacterBody2D

@export var speed := 420.0

@onready var duck_sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0.0:
		duck_sprite.flip_h = direction < 0.0

	velocity.x = direction * speed
	velocity.y = 0.0
	move_and_slide()

	var screen_width := get_viewport_rect().size.x
	global_position.x = clampf(global_position.x, 30.0, screen_width - 30.0)
