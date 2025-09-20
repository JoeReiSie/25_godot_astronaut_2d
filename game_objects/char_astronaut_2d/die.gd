extends StateFsmNode

@export var parent : PlayerAstronaut

func enter():
	parent.particel_enable(false)
	parent.char_visible(false)
	parent.explosion_enable(true)

func physics_update(_delta):
	pass
