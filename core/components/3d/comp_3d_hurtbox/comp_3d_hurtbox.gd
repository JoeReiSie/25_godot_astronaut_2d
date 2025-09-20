extends Area3D
class_name Comp3dHurtbox

# Diese Komponente erzeugt ein signsal wenn eine aktive hitbox
# trifft

signal hurt(damage)

# --------Variables-----------------------------------------------------------

# --------Functions-----------------------------------------------------------
func take_damage(damage_amount: float):
	hurt.emit(damage_amount)

func set_enable(state):
	monitoring = state
	

# --------Signals-------------------------------------------------------------
