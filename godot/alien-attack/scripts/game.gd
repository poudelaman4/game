extends Node2D
var lives = 3
var score = 0
@onready var player =$Player
@onready var hud = $UI/HUD 
@onready var ui = $UI
var gos_scene = preload("res://scenes/game_over.tscn")
func _ready() -> void:
	hud.set_score_label(score)
	hud.set_lifes(lives)
func _on_death_zone_area_entered(area: Area2D) -> void:
	if not is_instance_valid(area):
		print("WARNING: Tried to use a freed node in death zone.")
		return
	if area == player:
		decrease_life()
	elif area.is_in_group("enemies"):
		if lives >0:
			decrease_life()
			if is_instance_valid(area) and area.has_method("die"):
				area.die()
	else:
		if is_instance_valid(area):
			area.queue_free()
func _on_player_took_damage() -> void:
	lives -= 1
	hud.set_lifes(lives)
	if lives <= 0: # Use <= 0 to be safe
		player.die()
		var gos = gos_scene.instantiate()
		gos.set_score(score)
		ui.add_child(gos)
func decrease_life():
	lives -= 1
	hud.set_lifes(lives)
	if lives <= 0:
		player.die()
func _on_enemy_spawner_enemy_spawned(enemy_scene_instantiate: Variant) -> void:
	# NEW: Connect to the specific signal that means the player DEFEATED the enemy
	enemy_scene_instantiate.connect("enemy_defeated_by_player", _on_enemy_defeated)
	add_child(enemy_scene_instantiate)
# NEW/RENAMED: This function now only runs when the enemy is DEFEATED by the player
func _on_enemy_defeated():
	score += 1
	hud.set_score_label(score)
	# You would typically update a UI label here to show the score to the player.
