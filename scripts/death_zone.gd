extends Area2D

signal missed_ennemy

func _on_area_entered(area: Node) -> void:
	if area is Aliens:
		area.queue_free()
		emit_signal("missed_ennemy")