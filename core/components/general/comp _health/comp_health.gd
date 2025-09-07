extends Node
class_name CompHealth

signal health_changed
signal death

# --------Variables-----------------------------------------------------------
@export var health: int = 1
@export var max_health: int = 1

# --------Functions-----------------------------------------------------------
func _ready():
	set_max_health(max_health)
	heal(max_health)

func set_max_health(value : int):
	max_health = value
	
func get_max_health() -> int:
	return max_health
	
func heal(amount: int):
	_health_update(amount)

func damage(amount: int):
	_health_update(-amount)

func _health_update(amount: int):
	health += amount
	health = clamp(health, 0, max_health)
	health_changed.emit()
	if health == 0:
		death.emit()

func get_health() -> int:
	return health
