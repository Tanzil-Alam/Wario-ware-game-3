extends Area2D

@export var fall_speed := 280.0

func _physics_process(delta: float) -> void:
	position.y += fall_speed * delta
	if position.y > get_viewport_rect().size.y + 50.0:
		queue_free()
