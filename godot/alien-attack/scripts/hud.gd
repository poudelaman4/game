extends Control

@onready var life: Label = $lifes
@onready var score: Label = $Score
func set_score_label(new_score):
	score.text =  "SCORE: " + str(new_score)
func set_lifes(amount):
	life.text = str(amount)
