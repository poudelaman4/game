# rocket.gd
extends Area2D

@export var rocket_Speed: int = 540
@onready var notifier = $notify

func _ready() -> void:
	notifier.connect("screen_exited", _on_screen_exited)

func _physics_process(delta: float) -> void:
	global_position.y -= rocket_Speed * delta

func _on_screen_exited():
	# This handles rockets that fly off-screen without hitting anything.
	print("DEBUG: Rocket.gd: Screen exited. Queueing free.")
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	print("DEBUG: Rocket.gd: _on_area_entered with ", area.name)

	# **IMPORTANT:** Always queue_free the rocket itself *after* it interacts with the object.
	# This ensures the rocket disappears on hit.
	queue_free() # Free the rocket first to ensure it's removed.
	print("DEBUG: Rocket.gd: Rocket self-freed.")

	# Check if the collided area is valid *before* attempting to interact with it.
	if not is_instance_valid(area):
		print("DEBUG: Rocket.gd: Hit an invalid (already freed) area. Exiting.")
		return # Exit early if the area is not valid

	# Now, specifically handle what the rocket hit.
	if area.is_in_group("enemies"): # <-- Remember to change "enemies" if your group name is "killable_enemies"
		if area.has_method("hit_by_player_rocket"):
			# Call the enemy's dedicated method for being hit by a player rocket.
			# This method will handle the enemy's signal emission and its own death.
			area.hit_by_player_rocket()
			print("DEBUG: Rocket.gd: Called hit_by_player_rocket on enemy.")
		else:
			print("DEBUG: Rocket.gd: Hit an enemy, but it lacks 'hit_by_player_rocket' method: ", area.name)
	# Add other conditions here if your rocket hits other types of objects
	# Example:
	# elif area.is_in_group("obstacles"):
	#     area.break() # Or whatever method obstacles have
	else:
		print("DEBUG: Rocket.gd: Hit something unexpected or not an enemy: ", area.name)
