extends Node
class_name Comp3dMovementHorizontal

# This component handles the horizontal movement in a 3d area (x and z).
# It ignores the y axis.Must be a child of a CharacterBody3d

# Init in ready():
# component.set_speed(5)

# --------Variables-----------------------------------------------------------
var speed: float = 1
var direction: Vector3 = Vector3.ZERO

# --------Functions-----------------------------------------------------------
func set_direction(new_direction: Vector3):
	direction = new_direction

func set_speed(new_speed: float):
	speed = new_speed

func move():
	get_parent().velocity = direction * speed
	get_parent().move_and_slide()
	get_parent().look_at(Vector3(direction.x*1000, get_parent().global_position.y, direction.z*1000))
