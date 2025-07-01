extends Area2D
@onready var animate = $AnimatedSprite2D
func _ready() -> void:
	pass
func animater():
	animate.play("default")
