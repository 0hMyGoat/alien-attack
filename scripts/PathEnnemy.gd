extends Path2D

@onready var path_follow: PathFollow2D = $PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready():
	path_follow.set_progress_ratio(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path_follow.progress_ratio -= delta * 0.25
	if path_follow.progress_ratio == 0:
		queue_free()
