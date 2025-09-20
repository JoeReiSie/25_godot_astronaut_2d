extends Node
class_name CompFlowFieldMap

# The first thing to do is to initialize the map with
# nodename.initialize_map(5, 5)

# --------Variables-----------------------------------------------------------
var arr_cost: Array
var arr_integration: Array
var arr_flowfield: Array
var flow_field_size_x: int
var flow_field_size_y: int

# --------Functions-----------------------------------------------------------
func initialize_map(field_size_x: int, field_size_y: int):
	flow_field_size_x = field_size_x
	flow_field_size_y = field_size_y

	for x in range(0, flow_field_size_x):
		arr_cost.append([])
		arr_integration.append([])
		arr_flowfield.append([])
		for y in range(0, flow_field_size_y):
			arr_cost[x].append(1)
			arr_integration[x].append(65535)
			arr_flowfield[x].append(Vector2.ZERO)

func update_map(target: Vector2i):
	# calculate the integration field
	var value = 0
	var list = []
	var new_list = []

	for x in range(0, flow_field_size_x):
		for y in range(0, flow_field_size_y):
			arr_integration[x][y] = 255

	arr_integration[target.x][target.y] = 0
	list.append(target)

	while list:
		new_list.clear()
		for coor in list:
			if _is_valid_coor(coor.x-1, coor.y):
				value = arr_integration[coor.x][coor.y] + arr_cost[coor.x-1][coor.y]
				if value < arr_integration[coor.x-1][coor.y] and arr_cost[coor.x-1][coor.y] < 255:
					arr_integration[coor.x-1][coor.y] = value
					new_list.append(Vector2i(coor.x-1, coor.y))
			if _is_valid_coor(coor.x+1, coor.y):
				value = arr_integration[coor.x][coor.y] + arr_cost[coor.x+1][coor.y]
				if value < arr_integration[coor.x+1][coor.y] and arr_cost[coor.x+1][coor.y] < 255:
					arr_integration[coor.x+1][coor.y] = value
					new_list.append(Vector2i(coor.x+1, coor.y))
			if _is_valid_coor(coor.x, coor.y-1):
				value = arr_integration[coor.x][coor.y] + arr_cost[coor.x][coor.y-1]
				if value < arr_integration[coor.x][coor.y-1] and arr_cost[coor.x][coor.y-1] < 255:
					arr_integration[coor.x][coor.y-1] = value
					new_list.append(Vector2i(coor.x, coor.y-1))
			if _is_valid_coor(coor.x ,coor.y+1):
				value = arr_integration[coor.x][coor.y] + arr_cost[coor.x][coor.y+1]
				if value < arr_integration[coor.x][coor.y+1] and arr_cost[coor.x][coor.y+1] < 255:
					arr_integration[coor.x][coor.y+1] = value
					new_list.append(Vector2i(coor.x, coor.y+1))
		list.clear()
		list = new_list.duplicate()

	# calculate the flow field field
	for x in range(0, flow_field_size_x):
		for y in range(0, flow_field_size_y):
			var saved_vector = Vector2.ZERO
			var smallest_value = 255
			var temp_value = 0
			if not arr_integration[x][y] == 0:
				if _is_valid_coor(x-1, y):
					temp_value = arr_integration[x-1][y]
					if  temp_value < smallest_value:
						saved_vector = Vector2(-1, 0)
						smallest_value = temp_value
				if _is_valid_coor(x+1, y):
					temp_value = arr_integration[x+1][y]
					if temp_value < smallest_value:
						saved_vector = Vector2(1, 0)
						smallest_value = temp_value
				if _is_valid_coor(x, y-1):
					temp_value = arr_integration[x][y-1]
					if temp_value < smallest_value:
						saved_vector = Vector2(0, -1)
						smallest_value = temp_value
				if _is_valid_coor(x, y+1):
					temp_value = arr_integration[x][y+1]
					if temp_value < smallest_value:
						saved_vector = Vector2(0, 1)
						smallest_value = temp_value
				if _is_valid_coor(x-1, y-1):
					temp_value = arr_integration[x-1][y-1]
					if temp_value < smallest_value:
						saved_vector = Vector2(-1, -1)
						smallest_value = temp_value
				if _is_valid_coor(x-1, y+1):
					temp_value = arr_integration[x-1][y+1]
					if temp_value < smallest_value:
						saved_vector = Vector2(-1, 1)
						smallest_value = temp_value
				if _is_valid_coor(x+1, y-1):
					temp_value = arr_integration[x+1][y-1]
					if temp_value < smallest_value:
						saved_vector = Vector2(1, -1)
						smallest_value = temp_value
				if _is_valid_coor(x+1, y+1):
					temp_value = arr_integration[x+1][y+1]
					if temp_value < smallest_value:
						saved_vector = Vector2(1, 1)
						smallest_value = temp_value

			arr_flowfield[x][y] = saved_vector

func _is_valid_coor(x: int, y: int) -> bool:
	return x >= 0 and x < flow_field_size_x and y >= 0 and y < flow_field_size_y

func set_cost(cost: int, coor: Vector2i):
	arr_cost[coor.x][coor.y] = cost

func get_cost(coor: Vector2i):
	return arr_cost[coor.x][coor.y]

func get_vector(coor: Vector2i):
	return arr_flowfield[coor.x][coor.y]
# --------Signals-------------------------------------------------------------
