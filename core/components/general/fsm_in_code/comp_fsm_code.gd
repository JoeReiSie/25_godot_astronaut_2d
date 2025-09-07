extends Node
class_name CompFsmCode

# Step by step:
# - Add FSM Component as a child if the main object node:
# @onready var fsm: FsmCode = $FsmCode_Component
# - In the _ready() funtion you can jump to the initial state:
# fsm.change_state("name")
# - States are available by creating the functions like this:
# func fsm_name_enter()
# func fsm_name_process(delta)
# func fsm_name_physics_process(delta)
# func fsm_name_exit()

var current_state: String = ""

func _process(delta):
	var function_name = "state_" + current_state + "_process"
	if get_parent().has_method(function_name):
		get_parent().call(function_name, delta)


func _physics_process(delta: float) -> void:
	var function_name = "state_" + current_state + "_physics_process"
	if get_parent().has_method(function_name):
		get_parent().call(function_name, delta)


func change_state(new_state_name: String):
	if not new_state_name == "":
		if new_state_name != current_state:
			var function_name = "state_" + current_state + "_exit"
			if get_parent().has_method(function_name):
				get_parent().call(function_name)

			current_state = new_state_name

			function_name = "state_" + current_state + "_enter"
			if get_parent().has_method(function_name):
				get_parent().call(function_name)
