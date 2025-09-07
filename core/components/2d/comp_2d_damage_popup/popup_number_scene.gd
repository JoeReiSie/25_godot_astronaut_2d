extends Marker2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label_field: Label = $LabelContainer/Label
@onready var label_container: Node2D = $LabelContainer

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(label_container, "position", Vector2(0, -30), 1)

func set_text(text: String, color: Color):
	label_field.text = text
	label_field.modulate = color

func remove():
	animation_player.stop()
	queue_free()
