extends CharacterBody2D
@export var paddle_speed: float = 500.0
var ball_ref : Node2D
func _physics_process(delta: float) -> void:
	var direction = 0
	if ball_ref.global_position.x > global_position.x :
		direction = 1
	elif ball_ref.global_position.x < global_position.x:
		direction = -1 
	velocity.x = direction * paddle_speed
	velocity.y = 0
	move_and_slide()
