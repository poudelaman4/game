extends Node2D
signal enemy_spawned(enemy_scene_instantiate)
var enemy_scene = preload("res://scenes/enemy.tscn")

@onready var enemy_spawn_position = $SpawnPosition
#var rocket_scene_instantiate = rocket_scene.instantiate()
	#rocket_container.add_child(rocket_scene_instantiate)
	#rocket_scene_instantiate.global_position= global_position
	#rocket_scene_instantiate.scale = Vector2(0.5,0.5)
	#rocket_scene_instantiate.global_position.y -=70
func _on_timer_timeout() -> void:
	spawn()

func spawn():
	var spawn_position_array= enemy_spawn_position.get_children()
	var random_spawn_position = spawn_position_array.pick_random()
	var enemy_scene_instantiate = enemy_scene.instantiate()	
	enemy_scene_instantiate.global_position = random_spawn_position.global_position
	emit_signal("enemy_spawned",enemy_scene_instantiate)
