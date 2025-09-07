extends Node3D
class_name Comp3DMouseRaycast

# This function returns the first collider,
# that is hit by the rayast from camera in the direction of the mousepointer
# Examples for mask:
#          |  Hex   | Dec |  Bin               | Bitshift
# Layer 1  |  0x1   | 1   | 0b0000000000000001 | 1 << 0
# Layer 9  |  0x100 | 256 | 0b0000000100000000 | 1 << 8
func get_collider(mask: int = 0, areas: bool = true):
	var ray_length = 1000
	var active_camera = get_viewport().get_camera_3d()
	var mouse_position: Vector2 = get_viewport().get_mouse_position()

	var from = active_camera.project_ray_origin(mouse_position)
	var to = from + active_camera.project_ray_normal(mouse_position) * ray_length

	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.collide_with_areas = areas 		#true
	query.collision_mask = mask 			#0b0000000100000000
	var result = space_state.intersect_ray(query)
	if result:
		return result.collider
	return result
