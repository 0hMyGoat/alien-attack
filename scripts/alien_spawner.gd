extends Node

signal alien_spawned(alien: Node)

var ALIEN: PackedScene = preload("res://scenes/aliens.tscn")

@onready var SPAWN_POSITIONS: Array = $SpawnPositions.get_children()


func _on_timer_timeout():
	spawn_alien()


func spawn_alien() -> void:
	var alien = ALIEN.instantiate()
	alien.name = "Alien"
	alien.position = SPAWN_POSITIONS.pick_random().position
	emit_signal("alien_spawned", alien)

