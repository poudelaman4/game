extends Control

func set_score(new_score):
	$Panel/Score.text = "SCORE: " + str(new_score)
func _on_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_exit_pressed() -> void:
	get_tree().quit() # Replace with function body.
