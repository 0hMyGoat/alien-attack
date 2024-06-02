extends Node

signal alien_spawned(alien: Node)

var ALIEN: PackedScene = preload("res://scenes/aliens.tscn")

@onready var SPAWN_POSITIONS: Array = $SpawnPositions.get_children()
@onready var TIMER: Timer = $Timer

var ennemy_count: int = 0
var alien_speed: float = 300

func _on_timer_timeout():
	spawn_alien()


func spawn_alien() -> void:
	var alien = ALIEN.instantiate()
	alien.name = "Alien"
	alien.SPEED = alien_speed
	alien.position = SPAWN_POSITIONS.pick_random().position
	ennemy_count += 1
	emit_signal("alien_spawned", alien)
	increase_difficulty()

func increase_difficulty() -> void:
	if (ennemy_count % 50) == 0:
		alien_speed += 50
		increase_spawn_rate()

func increase_spawn_rate() -> void:
	if TIMER.wait_time > 0.5:
		TIMER.wait_time -= 0.1

