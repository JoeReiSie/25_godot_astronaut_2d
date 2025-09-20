extends Node
class_name CompFsmNode

# Instruction:
# - The statemaschine must be started in _ready() of the player skript:
#    fsm.start()
#
# - The initial_state in the inspector must be set.
# 
# - In the state nodes you have to create a variable with the classname to use autocomplete:
#    @export var parent : CharacterBody2D

@export var initial_state: StateFsmNode
var states_dict: Dictionary = {}
var current_state: StateFsmNode = null

func start() -> void:
	for child in get_children():
		child.fsm = self
		if child is StateFsmNode:
			states_dict[child.name.to_lower()] = child

	if initial_state:
		initial_state.enter()
		current_state = initial_state
	pass


func _process(delta):
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func change_state(state, new_state_name):
	if state != current_state:
		return

	var new_state = states_dict.get(new_state_name.to_lower())
	if !new_state:
		return

	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state

func get_current_state():
	return current_state
