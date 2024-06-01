extends Area2D

@export var SPEED: int = 300
@onready var VISIBLE_NOTIFiER: Node = $VisibleNotifier

func _ready() -> void:
	VISIBLE_NOTIFiER.connect("screen_exited", _on_screen_exited)

func _physics_process(delta: float) -> void:
	global_position.x += SPEED * delta

func _on_screen_exited() -> void:
	queue_free()

func hit() -> void:
	queue_free()

func _on_area_entered(area: Node) -> void:
	if area is Aliens:
		area.die()
		queue_free()
