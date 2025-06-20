extends Node2D
func _on_maze_body_exited(_body: Node2D) -> void:
	call_deferred("_reload_scene")
func _reload_scene():
	get_tree().reload_current_scene()
func _on_end_label_focus_entered() -> void:
	pass
