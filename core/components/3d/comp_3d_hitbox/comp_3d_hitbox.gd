extends Area3D
class_name Comp3dHitbox

# Init in ready():
# component.set_damage(5)
#
# TODO Bei jedem attack muss set_enable(true) aufgerufen werden
# und set_enable(false) wenn die attacke zu ende ist.

# --------Variables-----------------------------------------------------------
var damage: float = 1
var is_enable: bool = true

# --------Functions-----------------------------------------------------------
func _ready() -> void:
	area_entered.connect(_on_area_entered)

func set_damage(new_damage):
	damage = new_damage

func set_enable(state: bool):
	is_enable = state

# --------Signals-------------------------------------------------------------
func _on_area_entered(hurtbox_area: Area3D):
	if hurtbox_area is Comp3dHurtbox:
		if is_enable:
			if hurtbox_area.has_method("take_damage"):
				hurtbox_area.take_damage(damage)
