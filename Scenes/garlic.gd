extends Node2D

signal garlic_collected

var collected := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if collected or not body is CharacterBody2D:
		return

	collected = true
	$Area2D.set_deferred("monitoring", false)
	hide()
	garlic_collected.emit()
