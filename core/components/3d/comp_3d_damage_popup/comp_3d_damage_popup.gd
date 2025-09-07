extends Node
class_name Comp3dDamagePopup

# TODO: Diese Komponente erzeugt eine schadensanzeige über der
# Spielfigur

# --------Variables-----------------------------------------------------------
@export var popup_text_scene: PackedScene

# --------Functions-----------------------------------------------------------
func create_text(amount: float):
	var instance = popup_text_scene.instantiate()
	add_child(instance)
	instance.set_text(str(amount), Color.DARK_RED)
	var camera = get_viewport().get_camera_3d()
	var screen_position = camera.unproject_position(get_parent().global_position) + Vector2(0, -30)
	instance.global_position = screen_position
