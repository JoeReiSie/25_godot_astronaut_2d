@tool
extends Area2D
class_name comp2dViewbox

# Diese Komponente verwaltet alle objekt im Sichtbereich.
# Todo: Berechnen welche objekte sich im aktiven Sichtbereich befinden

# --------Variables-----------------------------------------------------------
@export var radius: float = 100.0
@export_range(0.0, 180.0, 1.0) var angle: float = 180.0
@export var thickness : float = 2.0
@export_range(6, 64) var resolution : int = 32
@export var line_color : Color = Color.CORNFLOWER_BLUE
@export var line_enable : bool = true:
	set(value):
		line_enable = value
		if value == false:
			queue_redraw()
var game_objects = []

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# --------Functions-----------------------------------------------------------
func _ready() -> void:
	collision_shape_2d.shape.radius = radius
	
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _process(delta: float) -> void:
	if line_enable:
		queue_redraw()

func get_objects() -> Array:
	return game_objects

func get_radius():
	return radius
	
func set_radius(new_radius: float):
	radius = new_radius
	collision_shape_2d.shape.radius = radius

func show_line():
	line_enable = true 
	
func hide_line():
	line_enable = false 

func _draw():
	if line_enable:
		var center = Vector2.ZERO
		var start_angle = deg_to_rad(-90 - angle)
		var end_angle = deg_to_rad(-90 + angle)

		# Kreisabschnitt
		draw_arc(center, radius, start_angle, end_angle, resolution, line_color, thickness)

		if angle < 180:
			# Linien von der Mitte zu den Endpunkten
			var start_point = center + Vector2(cos(start_angle), sin(start_angle)) * radius
			var end_point = center + Vector2(cos(end_angle), sin(end_angle)) * radius

			draw_line(center, start_point, line_color, thickness)
			draw_line(center, end_point, line_color, thickness)

# --------Signals-------------------------------------------------------------
func _on_area_entered(hurtbox_area: Area2D):
	if hurtbox_area is Comp2dHurtbox:
		game_objects.append(hurtbox_area.get_parent())

func _on_area_exited(hurtbox_area: Area2D):
	game_objects.erase(hurtbox_area.get_parent())
