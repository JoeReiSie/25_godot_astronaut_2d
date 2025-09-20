extends NavigationAgent3D
class_name Comp3dPathfinding

# --------Enum and Const-----------

# --------Export-------------------
@export var movement_component: Comp3dMovementHorizontal

# --------Variables----------------
var target
var direction
var rng = RandomNumberGenerator.new()
var offset
# --------Onready Variables--------

# --------Build-in Function--------
func _ready() -> void:
	velocity_computed.connect(_on_velocity_computed)
	offset = rng.randf_range(-1.5, 1.5)

func _process(delta: float) -> void:
	if not target == null:
		if target is Vector3:
			target_position = target
		else:
			target_position = target.global_position
		#navigation_update_timer.start(0.3)

	var next_way_point = get_next_path_position()
	direction = next_way_point - get_parent().global_position
	# normal zum nächsten punkt
	var normal = Vector3(-direction.normalized().z, direction.normalized().y, direction.normalized().x)
	# zum parallellaufen einen h_offset aufaddieren
	direction = direction - normal * offset
	direction = direction.normalized()
	if avoidance_enabled:
		set_velocity(direction)
	else:
		movement_component.set_direction(direction)

# --------Private Function---------

# --------Public Function----------
func set_target(new_target: Node3D):
	target = new_target


func _on_velocity_computed(safe_velocity: Vector3) -> void:
	movement_component.set_direction(safe_velocity)
