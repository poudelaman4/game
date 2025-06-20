extends RigidBody2D
const speed = 550



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		apply_force(Vector2(-speed , 0))
	if Input.is_action_pressed("move_right"):
		apply_force(Vector2(speed , 0))
	if Input.is_action_pressed("move_up"):
		apply_force(Vector2(0 , -speed))
	if Input.is_action_pressed("move_down"):
		apply_force(Vector2(0 , speed))
