class_name Player
extends CharacterBody2D

signal took_dammage

@onready var rocker_sound: AudioStreamPlayer = $RocketShotSound
@onready var FLAMES: GPUParticles2D = $FlameParticleEffect
@onready var boost_timer: Timer = Timer.new()

@export var BASE_SPEED: float = 300
@export var BOOST_SPEED: float = 600
@export var boost_duration: float = 3

var speed: float = 300
var SCREEN_SIZE: Vector2
var ROCKET: PackedScene = preload("res://scenes/rocket.tscn")

@export var lives: int = 3
@onready var ROCKET_CONTAINER: Node = $RocketContainer

func _ready() -> void:
	SCREEN_SIZE = get_viewport_rect().size
	add_child(boost_timer)
	boost_timer.connect("timeout", _on_boost_timeout)

func _physics_process(_delta: float) -> void:
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("move_down"):
		velocity.y += speed
	if Input.is_action_pressed("move_up"):
		velocity.y -= speed
	if Input.is_action_pressed("boost") and not boost_timer.is_stopped():
		speed = BOOST_SPEED
		FLAMES.amount = 100
		boost_timer.start(boost_duration)

	move_and_slide()

	global_position = global_position.clamp(Vector2(0, 0), SCREEN_SIZE)

func _on_boost_timeout() -> void:
	speed = BASE_SPEED
	FLAMES.lifetime = 0.3
	FLAMES.amount = 20

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