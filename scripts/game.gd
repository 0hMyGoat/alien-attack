extends Node2D

@export var lives: int = 3
@export var score: int = 0

@onready var PLAYER: Player = $Player
@onready var DEATH_ZONE: Area2D = $DeathZone
@onready var HUD_LAYOUT: HUD = $UI/HUD
@onready var alien_hit_sound: AudioStreamPlayer = $EnnemyHitSound
@onready var player_hit_sound: AudioStreamPlayer = $PlayerTakeDammageSound


var GANME_OVER_SCREEN: PackedScene = preload("res://scenes/game_over.tscn")
var EXPLOSION: PackedScene = preload("res://scenes/explosion.tscn")

func _ready():
	HUD_LAYOUT.update_score(score)
	HUD_LAYOUT.update_lives(lives)

func _on_player_took_dammage() -> void:
	if lives == 0:
		return
	player_hit_sound.play()
	lives -= 1
	HUD_LAYOUT.update_lives(lives)
	if lives == 0:
		explode(PLAYER.get_position())
		PLAYER.die()

		await get_tree().create_timer(1.5).timeout

		var game_over_screen = GANME_OVER_SCREEN.instantiate()
		game_over_screen.update_score(score)
		HUD_LAYOUT.add_child(game_over_screen)

func _on_alien_spawner_alien_spawned(aliens: Aliens):
	add_child(aliens)
	aliens.connect("died", _on_alien_died)

func _on_alien_died(alien_position: Vector2):
	alien_hit_sound.play()
	score += 10
	HUD_LAYOUT.update_score(score)
	explode(alien_position)

func _on_death_zone_missed_ennemy() -> void:
	_on_player_took_dammage()

func explode(position: Vector2) -> void:
	var explosion_particles = EXPLOSION.instantiate()
	explosion_particles.emitting = true
	explosion_particles.set_position(position)
	add_child(explosion_particles)