extends CharacterBody2D
class_name PlayerAstronaut

signal died

# --------Variables-----------------------------------------------------------
enum QUICK_DIR {LEFT, RIGHT}

@export var move_speed_max: float = 450		#maximal geschwindigkeit
@export var move_acc: float = 1000			#beschleunigen
@export var move_dec: float = 700			#abbremsen
@export var fall_speed_max: float = 500 	#maximale fallgeschwindigkeit
@export var fall_gravity: float = 600		#normale fallgeschwindigkeit
@export var fly_speed_max: float = 500  	#maximale fluggeschwindigkeit
@export var fly_force: float = -600 	    #beschleunigung

var look_direction = -1
var is_hit = false
var enable = true
const ROTATION_ANGLE = 10
const ROTATION_SPEED = 45
const ROTATION_SPEED_RESET = 25

@onready var sprite: AnimatedSprite2D = %Sprite
@onready var character: Marker2D = $char
@onready var particle_schub: CPUParticles2D = %particle_schub
@onready var explosion: CPUParticles2D = %explosion
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var comp_2d_move_astro: Comp2dMoveAstro = $comp_2d_move_astro
@onready var comp_input_keyboard: Node = $comp_input_keyboard
@onready var ring: Sprite2D = $char/ring
@onready var fsm: CompFsmNode = $FSM

# --------Functions-----------------------------------------------------------
func _ready() -> void:
	fsm.start()

func _physics_process(delta: float) -> void:
	Debug.print_value("FPS", Engine.get_frames_per_second())
	Debug.print_value("Player_Velocity", velocity)
	Debug.print_value("Player_State", fsm.current_state)

func rotate_character(delta: float, input: float):
	if input > 0:
		character.rotation_degrees = move_toward(character.rotation_degrees, input * ROTATION_ANGLE, ROTATION_SPEED * delta)
		if look_direction < 0:
			look_direction = 1
			animation_player.play("rotation")
	elif input < 0:
		character.rotation_degrees = move_toward(character.rotation_degrees, input * ROTATION_ANGLE, ROTATION_SPEED * delta)
		if look_direction > 0:
			look_direction = -1
			animation_player.play_backwards("rotation")
	else:
		character.rotation_degrees = move_toward(character.rotation_degrees, 0, ROTATION_SPEED_RESET * delta) 

func quick_direction(dir: QUICK_DIR):
	if dir == QUICK_DIR.RIGHT:
		look_direction = 1
		animation_player.play("rotation")
		animation_player.seek(animation_player.get_animation("rotation").length, true)
	else:
		look_direction = -1
		animation_player.play_backwards("rotation")
		animation_player.seek(0, true)

func particel_enable(is_emitting: bool):
	particle_schub.emitting = is_emitting

func ring_enable(is_showing: bool):
	ring.visible = is_showing

func explosion_enable(is_emitting: bool):
	explosion.emitting = is_emitting

func char_visible(is_showing: bool):
	character.visible = is_showing

func get_collision():
	return is_hit

# --------Signals-------------------------------------------------------------
func _on_hitarea_area_entered(area: Area2D) -> void:
	is_hit = true

func _on_hitarea_body_entered(body: Node2D) -> void:
	is_hit = true

func _on_explosion_finished() -> void:
	died.emit()
