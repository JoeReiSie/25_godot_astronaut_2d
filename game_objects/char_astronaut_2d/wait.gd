extends StateFsmNode

@export var parent : PlayerAstronaut

func enter():
	parent.ring_enable(true)

func physics_update(_delta):
	# Inputs
	var inputs = parent.comp_input_keyboard.get_input()
	# Gravity
	
	# Movement
	
	# Move and slide
	
	# change state
	if inputs["jump_just_pressed"]:
		change_state("fly")


func exit():
	parent.ring_enable(false)
