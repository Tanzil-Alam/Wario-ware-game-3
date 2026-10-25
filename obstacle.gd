extends Area2D

signal player_hit

@export var speed: float = 400.0

func _ready() -> void:
	position.x = 1200.0

func _physics_process(delta: float) -> void:
	position.x -= speed * delta

	if position.x + $CollisionShape2D.position.x < -50.0:
		position.x = 1200

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_hit.emit()
