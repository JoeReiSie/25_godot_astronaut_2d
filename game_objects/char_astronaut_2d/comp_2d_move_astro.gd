extends Node
class_name Comp2dMoveAstro

var dead_zone: float = 0.01

@export var obj: CharacterBody2D
	
func _ready():
	if obj == null:
		push_warning("Reference node missing!")
		assert(false)
		
func set_movement(delta:float, input: float, move_max_speed: float, move_acc: float, move_dec: float):
	if abs(input) > dead_zone:
		obj.velocity.x = move_toward(obj.velocity.x, input * move_max_speed, move_acc * delta)
	else:
		obj.velocity.x = move_toward(obj.velocity.x, 0, move_dec * delta)


func set_gravity(delta:float, gravity: float, gravity_max_speed: float):
	obj.velocity.y += gravity * delta
	obj.velocity.y = clamp(obj.velocity.y, -gravity_max_speed, gravity_max_speed)


func apply_movement():
	obj.move_and_slide()
