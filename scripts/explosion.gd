extends GPUParticles2D

func _process(_delta: float) -> void:
	if not self.emitting:
		queue_free()

func small_explosion():
	self.amount = 50
	self.lifetime = 0.5
	self.emitting = true

func big_explosion():
	self.amount = 200
	self.lifetime = 2
	self.emitting = true