extends CharacterBody2D
class_name  Player
@onready var animate = $AnimatedSprite2D
@export var gravity = 250
@export var speed = 125
@export var jump_force = 125
var max_jump = 1
var current_jump = 0
var active = true
func _physics_process(delta: float) -> void:
	if is_on_floor() == false:
		velocity.y += gravity*delta
		if velocity.y > 500:
			velocity.y = 500
	else:
		current_jump=0
	var direction =0 
	if active == true:
		if Input.is_action_just_pressed("jump") && current_jump<max_jump:
			current_jump +=1
			jump(jump_force)
		direction  = Input.get_axis("move_left","move_right")
	if direction !=0 :
		animate.flip_h = (direction == -1)
	velocity.x = speed * direction
	move_and_slide()
	update_animation(direction)
func jump(force):
	velocity.y = -force
func update_animation(direction):
	if is_on_floor():
		if direction == 0:
			animate.play("idle")
		if direction != 0:
			animate.play("run")
	else:
		if velocity.y < 0:
			animate.play("jump")
		if velocity.y > 0:
			animate.play("fall")
