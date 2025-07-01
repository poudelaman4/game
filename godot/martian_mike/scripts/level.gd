extends Node2D
@export var next_level : PackedScene = null
@onready var vel = $player
@onready var start = $start
@onready var exit = $exit
func _ready() -> void:
	var traps = get_tree().get_nodes_in_group("traps")
	print(traps)
	for trap in traps:
		trap.connect("touched_player",_on_trap_touched_player)
	exit.body_entered.connect(_on_exit_body_entered)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
func _on_deathzone_body_entered(body: Node2D) -> void:
	reset_player()
func _on_trap_touched_player() -> void:
	reset_player()
func reset_player():
	vel.velocity = Vector2.ZERO
	vel.global_position = start.get_spwan_pos()
func _on_exit_body_entered(body):
	if body is Player:
		if next_level != null:
			exit.animater()
			vel.active = false
			await get_tree().create_timer(1.1).timeout
			get_tree().change_scene_to_packed(next_level)
		
		
