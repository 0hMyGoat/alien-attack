class_name HUD
extends Control

@onready var score_label: Label = $Score
@onready var lives_label: Label = $Lives

func update_score(score: int) -> void:
	score_label.text = "Score: " + str(score)

func update_lives(lives: int) -> void:
	lives_label.text = str(lives)