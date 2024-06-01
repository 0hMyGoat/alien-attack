extends Control
class_name GameOverScreen

func update_score(score):
	$Panel/Score.text = "Score: " + str(score)

func _on_button_pressed():
	get_tree().reload_current_scene()