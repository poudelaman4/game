extends Node2D
@export var speed: float = 200.0 # Pixels per second
var destroy_x_position: float = -100.0 # For a 480px wide screen, -100px is safely off-screen
func _ready() -> void:
	pass # Nothing specific to do here for now, as positioning is dynamic.
func _process(delta: float) -> void:
	position.x -= speed * delta
	# Check if the pipe is far enough off-screen to the left.
	if position.x < destroy_x_position:
		# If it is, remove it from the scene tree.
		# queue_free() is Godot's safe way to delete a node.
		queue_free()
