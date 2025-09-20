@tool
extends Node2D

enum {OFF, WARNING, ON}

@export_range(1, 30, 1) var lenght : int = 10:
	set(value):
		lenght = value
		_update_lenght()
@export var editor_animation : bool = false:
	set(value):
		editor_animation = value
		if value == false:
			line.visible = true
			particle.visible = true
			collision_shape_2d.visible = true
			particle_prepare.visible = true
@export var warning_time: float = 1.0
@export var on_time: float = 1.2
@export var off_time: float = 2.0

var state = OFF
var state_timer: float
const TILE_SIZE = 64

@onready var particle: CPUParticles2D = $Particle
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var line: Line2D = $Line
@onready var collision_shape_2d: CollisionShape2D = $Comp2dHitbox/CollisionShape2D
@onready var particle_prepare: CPUParticles2D = $Particle_Prepare

func _ready() -> void:
	_update_lenght()
	
func _process(delta: float) -> void:
	state_timer += delta
	
	if not Engine.is_editor_hint() or editor_animation:
		match state:
			OFF:
				line.visible = false
				particle.visible = false
				collision_shape_2d.visible = false
				particle_prepare.visible = false
				
				if state_timer > off_time:
					state_timer = 0
					state = WARNING
			WARNING:
				line.visible = false
				particle.visible = false
				collision_shape_2d.visible = false
				particle_prepare.visible = true
				
				if state_timer > off_time:
					state_timer = 0
					state = ON
			ON:
				line.visible = true
				particle.visible = true
				collision_shape_2d.visible = true
				particle_prepare.visible = true
				
				if state_timer > off_time:
					state_timer = 0
					state = OFF

		# Im spiel raycast beachten 
		#_update_lenght()

func _update_lenght() -> void:
	var collision_point : Vector2 = Vector2.ZERO
	var ray_length : float = 0.0
	
	if not ray_cast_2d:
		return
	
	# set target position
	ray_cast_2d.target_position = Vector2(0, -lenght * TILE_SIZE)
	
	# check if there is a collision
	if ray_cast_2d.is_colliding():
		collision_point = ray_cast_2d.get_collision_point() - global_position
		ray_length = collision_point.length()
	else:
		collision_point = ray_cast_2d.target_position
		ray_length = collision_point.length()
	
	# set particle
	particle.position.y = collision_point.y
	# set line
	line.set_point_position(1, Vector2(0,collision_point.y))
	# set collision shape
	var rect_shape = collision_shape_2d.shape
	if rect_shape is RectangleShape2D:
		rect_shape.extents.y = ray_length / 2
	collision_shape_2d.global_position.y = global_position.y + collision_point.y / 2
