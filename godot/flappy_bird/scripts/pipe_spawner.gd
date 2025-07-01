extends Node2D # IMPORTANT: Must be Node2D for viewport access

@onready var player = get_parent().find_child("player") # Get reference to the Player node

@export_file("*.tscn") var pipe_scene_path: String # Path to the Pipe.tscn scene

@export var min_y_offset: float = -150.0 # Min vertical offset for pipe gap from screen center
@export var max_y_offset: float = 150.0   # Max vertical offset for pipe gap from screen center
@export var spawn_x_position: float = 550.0 # X position where pipes appear (off-screen right)
var score =0 

func _ready() -> void:
	# Basic error checking for scene path
	if pipe_scene_path.is_empty():
		push_error("Pipe Scene Path is not set in PipeSpawner! Please assign 'Pipe.tscn' in the Inspector.")
		set_process(false) # Disable script if essential setup is missing
		return

	# Seed the random number generator for varied pipe heights
	seed(Time.get_ticks_msec())

	# Basic error checking for player node
	if not is_instance_valid(player):
		push_error("Player node not found! Make sure 'Player' node exists as a sibling to PipeSpawner and is named 'Player'.")
		set_process(false)


func _on_spawn_timer_timeout() -> void:
	# Load the pipe scene resource
	var pipe_scene = load(pipe_scene_path)
	if not pipe_scene: # Check if loading failed
		push_error("Failed to load pipe scene at path: %s" % pipe_scene_path)
		return

	# Create a new instance of the pipe scene
	var new_pipe_instance = pipe_scene.instantiate()

	# --- Connect Signals for Collision with Pipes ---
	# We connect the pipe's Area2D signals to the Player's _on_game_over function dynamically.
	if is_instance_valid(player):
		var top_pipe_area = new_pipe_instance.find_child("TopPipe")
		if top_pipe_area:
			# When player's physics body enters TopPipe's Area2D, call Player._on_game_over()
			top_pipe_area.body_entered.connect(player._on_game_over)
		var bottom_pipe_area = new_pipe_instance.find_child("BottomPipe")
		if bottom_pipe_area:
			# When player's physics body enters BottomPipe's Area2D, call Player._on_game_over()
			bottom_pipe_area.body_entered.connect(player._on_game_over)
		var score_area = new_pipe_instance.find_child("ScoreArea")
		if score_area:
			score += 1
			print(score)
	# Add the new pipe instance to the Main scene as a child
	get_parent().add_child(new_pipe_instance)

	# Calculate random Y position for the pipe's gap
	var random_y_offset = randf_range(min_y_offset, max_y_offset)
	var final_y_position = (get_viewport_rect().size.y / 2) + random_y_offset

	# Set the position of the new pipe instance
	new_pipe_instance.position = Vector2(spawn_x_position, final_y_position)
