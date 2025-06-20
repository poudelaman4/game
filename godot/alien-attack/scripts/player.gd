extends CharacterBody2D
var rocket_scene = preload("res://scenes/rocket.tscn")
var vel: int = 500
signal took_damage
@onready var rocket_container = $RocketContainer
func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		velocity = Vector2(-vel,0)
		move_and_slide()
	if Input.is_action_pressed("move_right"):
			velocity = Vector2(vel,0)
			move_and_slide()
	if Input.is_action_pressed("move_up"):
			velocity = Vector2(0,-vel)
			move_and_slide()
	if Input.is_action_pressed("move_down"):
			velocity = Vector2(0,vel)
			move_and_slide()
	global_position = global_position.clamp(Vector2(50,50),Vector2(670,750))
func _process(_delta: float) -> void:
		if Input.is_action_just_pressed("shoot"):
			shoot()
func take_damage():
	emit_signal("took_damage")
func shoot():
	var rocket_scene_instantiate = rocket_scene.instantiate()
	rocket_container.add_child(rocket_scene_instantiate)
	rocket_scene_instantiate.global_position= global_position
	rocket_scene_instantiate.scale = Vector2(0.5,0.5)
	rocket_scene_instantiate.global_position.y -=70
func die():
	queue_free()
	#if global_position.x<50:
		#global_position.x=50
	#if global_position.x>670:
		#global_position.x=670
	#if global_position.y<50:						main important logic down godot optimization
		#global_position.y=50
	#if global_position.y>750:
		#global_position.y=750
	#global_position.x = clamp(global_position.x, 50, 670)
	#global_position.y = clamp(global_position.y, 50, 750)   		slightly optimized
