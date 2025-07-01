extends RigidBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_velocity = Vector2(0,200)
	print(linear_velocity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if body.name == "player" or body.name == "EnemyAI":
		print("hello")
		linear_velocity = linear_velocity * 1.1 # This made it generally faster
		# NEW LINES: Make sure it always bounces up or down enough.
		# 'abs()' means 'make it positive' (so -100 becomes 100).
		# 'sign()' means 'tell me if it's going up (1), down (-1), or sideways (0)'.
		if abs(linear_velocity.y) < 250: # If its up-down speed is too small (less than 200)
			linear_velocity.y = 250 * sign(linear_velocity.y) # Make its up-down speed at least 200 (keeping its direction!)
