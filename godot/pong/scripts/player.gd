# player.gd
extends CharacterBody2D
# Exported variable allows easy adjustment in the Godot Inspector
@export var paddle_speed: float = 400.0
# Called every physics frame; ideal for movement and physics interactions
func _physics_process(_delta: float) -> void:
	var input_direction = 0.0 # Variable to capture horizontal input: -1 (left), 0 (none), 1 (right)
	# Check for horizontal input actions
	if Input.is_action_pressed("move_right"):
		input_direction = 1.0
	elif Input.is_action_pressed("move_left"):
		input_direction = -1.0
	# Calculate velocity based on input and speed
	velocity.x = input_direction * paddle_speed 
	velocity.y = 0.0 # Ensure no vertical movement for a horizontal paddle
	# Apply movement and handle collisions
	move_and_slide()
	var clamped_x = clamp(global_position.x, 50.0, 670.0)
	global_position = Vector2(clamped_x, global_position.y)
