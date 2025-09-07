extends Node
class_name Comp2dDamagePopup

# TODO: Diese Komponente erzeugt eine schadens oder heilungs-anzeige über der
# Spielfigur

# --------Variables-----------------------------------------------------------
@export var popup_text_scene: PackedScene
@export var text_size: float = 1

# --------Functions-----------------------------------------------------------
func create_text(amount: float):
	var instance = popup_text_scene.instantiate()
	get_tree().get_root().add_child(instance)
	instance.scale = Vector2(text_size, text_size)
	if amount > 0:
		instance.set_text(str(int(amount)), Color.DARK_GREEN)
	else:
		instance.set_text(str(int(amount)), Color.DARK_RED)
	
	instance.global_position = get_parent().global_position - Vector2(0, -3)
