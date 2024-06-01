class_name Player
extends CharacterBody2D

signal took_dammage

@onready var rocker_sound: AudioStreamPlayer = $RocketShotSound

var SPEED: float = 300
var SCREEN_SIZE: Vector2
var ROCKET: PackedScene = preload("res://scenes/rocket.tscn")

@export var lives: int = 3
@onready var ROCKET_CONTAINER: Node = $RocketContainer

func _ready() -> void:
	SCREEN_SIZE = get_viewport_rect().size


func _physics_process(_delta: float) -> void:
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += SPEED
	if Input.is_action_pressed("move_left"):
		velocity.x -= SPEED
	if Input.is_action_pressed("move_down"):
		velocity.y += SPEED
	if Input.is_action_pressed("move_up"):
		velocity.y -= SPEED

	move_and_slide()

	global_position = global_position.clamp(Vector2(0, 0), SCREEN_SIZE)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot() -> void:
	rocker_sound.play()
	var rocket_instance: Node2D = ROCKET.instantiate()

	ROCKET_CONTAINER.add_child(rocket_instance)
	rocket_instance.global_position = global_position

	rocket_instance.global_position.x += 80

func take_dammage() -> void:
	emit_signal("took_dammage")

func die():
	queue_free()