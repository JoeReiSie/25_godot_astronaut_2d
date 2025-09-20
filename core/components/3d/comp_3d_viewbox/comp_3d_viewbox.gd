extends Area3D
class_name comp3dViewbox

# Diese Komponente verwaltet alle objekt im sichtbereich.
# Benötigt eine CollisionShape3D

# --------Variables-----------------------------------------------------------
var game_objects = []

# --------Functions-----------------------------------------------------------
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func get_objects() -> Array:
	return game_objects

# --------Signals-------------------------------------------------------------
func _on_area_entered(hurtbox_area: Area3D):
	if hurtbox_area is Comp3dHurtbox:
		game_objects.append(hurtbox_area.get_parent())

func _on_area_exited(hurtbox_area: Area3D):
	game_objects.erase(hurtbox_area.get_parent())
