# enemy.gd
extends Area2D

@export var enemy_speed = 200
signal enemy_defeated_by_player # Signal for when this enemy is defeated by the player

func _physics_process(delta: float) -> void:
	global_position.y += enemy_speed * delta

func die():
	# This function is the ONLY place that calls queue_free() for the enemy.
	print("DEBUG: Enemy.gd: die() called. Queueing free.")
	queue_free()

func hit_by_player_rocket():
	# This method is called by the rocket when it hits this enemy.
	print("DEBUG: Enemy.gd: hit_by_player_rocket() called. Emitting signal and dying.")
	emit_signal("enemy_defeated_by_player") # Emit the signal FIRST
	die() # Then, call the die function to remove the enemy from the scene

func _on_body_entered(body: Node2D) -> void:
	# This handles collisions where the enemy hits something other than a player rocket
	# (e.g., the player itself, or a death zone).
	print("DEBUG: Enemy.gd: _on_body_entered with: ", body.name)
	if body.has_method("take_damage"): # Assuming your player has this method
		body.take_damage()
	die() # Enemy dies regardless of what it hit in this scenario (no score for this type of death)
