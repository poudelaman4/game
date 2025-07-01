extends StaticBody2D
@onready var spawnpos = $spawnposition
func get_spwan_pos():
	return spawnpos.global_position
