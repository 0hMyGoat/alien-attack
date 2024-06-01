class_name Aliens
extends Area2D

signal died(alien_position: Vector2)

@export var SPEED: int = 300

func _physics_process(delta: float) -> void:
	global_position.x += -SPEED * delta

func _on_body_entered(body: Node) -> void:
	if body is Player:
		body.take_dammage()
		queue_free()

func die() -> void:
	emit_signal("died", global_position)
	queue_free()
