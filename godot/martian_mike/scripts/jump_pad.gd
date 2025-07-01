extends Area2D
@onready var animate = $AnimatedSprite2D
@export var jump_force: float =200.0
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animate.play("jumper")
		body.jump(jump_force)
