extends CharacterBody2D

const SPEED := 300.0
const JUMP_VELOCITY := -550.0

@onready var duck_sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up")) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0.0:
		duck_sprite.flip_h = direction < 0.0

	velocity.x = direction * SPEED
	move_and_slide()
