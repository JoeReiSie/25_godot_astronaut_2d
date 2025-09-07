extends StaticBody2D

func _physics_process(delta: float) -> void:
	rotation_degrees += 40 * delta
