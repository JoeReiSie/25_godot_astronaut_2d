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
	add_keyboard_mapping()
	
func add_keyboard_mapping():
	# Neue Aktion hinzufügen
	if not InputMap.has_action("left"):
		InputMap.add_action("left")
		input_event = InputEventKey.new()
		input_event.keycode = KEY_A
		InputMap.action_add_event("left", input_event)
		input_event = InputEventKey.new()
		input_event.keycode = KEY_LEFT
		InputMap.action_add_event("left", input_event)
		
	if not InputMap.has_action("right"):
		InputMap.add_action("right")
		input_event = InputEventKey.new()
		input_event.keycode = KEY_D
		InputMap.action_add_event("right", input_event)
		input_event = InputEventKey.new()
		input_event.keycode = KEY_RIGHT
		InputMap.action_add_event("right", input_event)
		
	if not InputMap.has_action("up"):
		InputMap.add_action("up")
		input_event = InputEventKey.new()
		input_event.keycode = KEY_W
		InputMap.action_add_event("up", input_event)
		input_event = InputEventKey.new()
		input_event.keycode = KEY_UP
		InputMap.action_add_event("up", input_event)
		
	if not InputMap.has_action("down"):
		InputMap.add_action("down")
		input_event = InputEventKey.new()
		input_event.keycode = KEY_S
		InputMap.action_add_event("down", input_event)
		input_event = InputEventKey.new()
		input_event.keycode = KEY_DOWN
		InputMap.action_add_event("down", input_event)
		
	if not InputMap.has_action("jump"):
		InputMap.add_action("jump")
		input_event = InputEventKey.new()
		input_event.keycode = KEY_SPACE
		InputMap.action_add_event("jump", input_event)
		
	#if not InputMap.has_action("sprint"):
		#InputMap.add_action("sprint")
		#input_event = InputEventKey.new()
		#input_event.keycode = KEY_SHIFT
		#InputMap.action_add_event("sprint", input_event)
		#
	#if not InputMap.has_action("zoom_in"):
		#InputMap.add_action("zoom_in")
		#input_event = InputEventMouseButton.new()
		#input_event.button_index = MOUSE_BUTTON_WHEEL_UP
		#input_event.pressed = true
		#InputMap.action_add_event("zoom_in", input_event)
		#
	#if not InputMap.has_action("zoom_out"):
		#InputMap.add_action("zoom_out")
		#input_event = InputEventMouseButton.new()
		#input_event.button_index = MOUSE_BUTTON_WHEEL_DOWN
		#input_event.pressed = true
		#InputMap.action_add_event("zoom_out", input_event)

func get_input() -> Dictionary:
	var dict_input = {
		"x_axis_left": 0.0,
		"y_axis_left":0.0,
		"x_axis_right": 0.0,
		"y_axis_right":0.0,
		"jump_just_pressed": false,
		"jump": false,
	}
		
	dict_input["x_axis_left"] = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("jump"):
		dict_input["jump_just_pressed"] = true
	else:
		dict_input["jump_just_pressed"] = false
			
	if Input.is_action_pressed("jump"):
		dict_input["jump"] = true
	else:
		dict_input["jump"] = false

	return dict_input
