@tool
extends Node2D

@export var max_distance = -1000

@onready var particle: CPUParticles2D = $Particle
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var line: Line2D = $Line

func _physics_process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		var collision_point = ray_cast_2d.get_collision_point()
		particle.position = collision_point
		line.set_point_position(1, collision_point)
	else:
		particle.position = ray_cast_2d.target_position
		line.set_point_position(1, ray_cast_2d.target_position)
