extends CanvasLayer
class_name UiFadeScreen

signal fade_in_completed
signal fade_out_completed

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func fade_in():
	animation_player.play("fade_in")

func fade_out():
	animation_player.play("fade_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		fade_in_completed.emit()
	if anim_name == "fade_out":
		fade_out_completed.emit()
