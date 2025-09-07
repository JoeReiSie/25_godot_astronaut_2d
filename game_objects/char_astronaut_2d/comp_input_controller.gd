extends Node

# Standard buttons which you can map to a controller
# Controller		Keyboard		Example usage
# left stick		wasd			e.g move
# right stick 		mouse 			e.g camera
# down_symbol 		space			e.g jump
# right_symbol		x				e.g dodge/cancel
# left_symbol		e				e.g interact
# up_symbol			ctrl			e.g crouch
# dpad_down			4				e.g weapon change
# dpad_right		3				e.g
# dpad_left			2/tab			e.g map
# dpad_up			1				e.g potion
# l1_button							e.g
# l2_button			q				e.g block
# l3_button			shift			e.g toogle sprint
# r1_button			LMB				e.g attack
# r2_button							e.g special attack
# r3_button			-				e.g camera reset
# start_button		esc				e.g main menu
# share_button		enter			e.g

var input_event

func _ready() -> void:
	add_controller_mapping()
	
func add_controller_mapping():
	if not InputMap.has_action("left"):
		InputMap.add_action("left")
	input_event = InputEventJoypadMotion.new()
	input_event.axis = JOY_AXIS_LEFT_X
	input_event.axis_value = -1.0
	InputMap.action_add_event("left", input_event)
		
	if not InputMap.has_action("right"):
		InputMap.add_action("right")
	input_event = InputEventJoypadMotion.new()
	input_event.axis = JOY_AXIS_LEFT_X
	input_event.axis_value = +1.0
	InputMap.action_add_event("right", input_event)
		
	if not InputMap.has_action("up"):
		InputMap.add_action("up")
	input_event = InputEventJoypadMotion.new()
	input_event.axis = JOY_AXIS_LEFT_Y
	input_event.axis_value = -1.0
	InputMap.action_add_event("up", input_event)
	
	if not InputMap.has_action("down"):
		InputMap.add_action("down")
	input_event = InputEventJoypadMotion.new()
	input_event.axis = JOY_AXIS_LEFT_Y
	input_event.axis_value = +1.0
	InputMap.action_add_event("down", input_event)
		
	if not InputMap.has_action("jump"):
		InputMap.add_action("jump")
	input_event = InputEventJoypadButton.new()
	input_event.button_index = JOY_BUTTON_Y
	input_event.pressed = true
	InputMap.action_add_event("jump", input_event)
	
	#if not InputMap.has_action("attack"):
		#InputMap.add_action("attack")
	#input_event = InputEventJoypadButton.new()
	#input_event.button_index = JOY_BUTTON_X
	#input_event.pressed = true
	#InputMap.action_add_event("attack", input_event)
	#
	#if not InputMap.has_action("action"):
		#InputMap.add_action("action")
	#input_event = InputEventJoypadButton.new()
	#input_event.button_index = JOY_BUTTON_A
	#input_event.pressed = true
	#InputMap.action_add_event("action", input_event)
	#
	#if not InputMap.has_action("cancel"):
		#InputMap.add_action("cancel")
	#input_event = InputEventJoypadButton.new()
	#input_event.button_index = JOY_BUTTON_B
	#input_event.pressed = true
	#InputMap.action_add_event("cancel", input_event)
