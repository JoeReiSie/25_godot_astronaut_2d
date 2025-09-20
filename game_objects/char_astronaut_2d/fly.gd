extends StateFsmNode

@export var parent : PlayerAstronaut

func enter():
	parent.particel_enable(true)


func physics_update(delta):
	# Inputs
	var inputs = parent.comp_input_keyboard.get_input()
	
	# Gravity
	parent.comp_2d_move_astro.set_gravity(delta, parent.fly_force, parent.fly_speed_max)
	
	# Movement
	parent.comp_2d_move_astro.set_movement(delta, inputs["x_axis_left"], parent.move_speed_max, parent.move_acc, parent.move_dec)
	
	# Move and slide
	parent.comp_2d_move_astro.apply_movement()
	
	# Visual / Rotation
	parent.rotate_character(delta, inputs["x_axis_left"])
	
	# change state
	if parent.get_collision():
		change_state("die")
	if not inputs["jump"]:
		change_state("fall")

func exit():
	parent.particel_enable(false)
