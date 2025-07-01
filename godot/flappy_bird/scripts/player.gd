extends CharacterBody2D
@onready var animated_sprite= $AnimatedSprite2D
@onready var flap_sound = $FlapSound
@onready var hit_sound = $HitSound
@export var flap_velocity: float = -350.0
@export var gravity = 1000
@export var start_position: Vector2 = Vector2(150, 200)
func _ready() -> void:
	global_position = start_position
	animated_sprite.play("bird")
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	move_and_slide()
	if global_position.y> get_viewport_rect().size.y+50:
		_on_game_over()
func _unhandled_input(event):
	if event.is_action_pressed("flap"):
		velocity.y = flap_velocity
		flap_sound.play()
func _on_game_over(_body: Node2D = null):
	if hit_sound.playing:
		return
	hit_sound.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()
