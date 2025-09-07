extends Node

const PATH_LENGHT = 8
const WIDTH = 7
const HEIGHT = PATH_LENGHT
const BIT_NORTH = 1
const BIT_EAST = 2
const BIT_SOUTH = 4
const BIT_WEST = 8

var dungeon_grid = []
var rng =RandomNumberGenerator.new()
var current_position : Vector2i
var lenght : int
var dir = 0
var room_list = []
var first_debug_room = "res://game/rooms/4_start_plattform.tscn"
var first_room_x
var first_room_y
var boss_room_x
var boss_room_y

func _ready() -> void:
	create_dungeon(first_debug_room)

func create_dungeon(initial_room: String):
	_create_dungeon_array()
	_set_coor(3, 0)
	_generate_map()
	_create_room_list("res://game/rooms/")
	_fill_map(initial_room)
	
	for x in WIDTH:
		print(dungeon_grid[x])
	
func _create_dungeon_array():
	# Array leeren
	dungeon_grid.clear()
	# 2D array erzeugen
	for x in WIDTH:
		dungeon_grid.append([])
		for y in HEIGHT:
			dungeon_grid[x].append(0)
		
func _set_coor(x, y):
	current_position = Vector2i(x, y)
	
func _generate_map():
	# Erster Raum
	first_room_x = current_position.x
	first_room_y = current_position.y
	
	lenght = 1
	# Pfad erstellen
	while lenght < PATH_LENGHT:
		# zufaellig eine richtung auswaehlen
		if lenght == 1 or lenght == PATH_LENGHT:
			dir = 2
		else :
			dir = rng.randi_range(1,3)
		
		if dir == 1:
			# ost
			if current_position.x < WIDTH-1:
				if dungeon_grid[current_position.x + 1][current_position.y] == 0:
					dungeon_grid[current_position.x][current_position.y] += BIT_EAST
					current_position.x += 1
					lenght += 1
					dungeon_grid[current_position.x][current_position.y] += BIT_WEST
		elif dir == 2:
			# sued
			if current_position.y < HEIGHT-1:
				if dungeon_grid[current_position.x][current_position.y + 1] == 0:
					dungeon_grid[current_position.x][current_position.y] += BIT_SOUTH
					current_position.y += 1
					lenght += 1
					dungeon_grid[current_position.x][current_position.y] += BIT_NORTH
		elif dir == 3:
			# west
			if current_position.x > 0:
				if dungeon_grid[current_position.x - 1][current_position.y] == 0:
					dungeon_grid[current_position.x][current_position.y] += BIT_WEST 
					current_position.x -= 1
					lenght += 1
					dungeon_grid[current_position.x][current_position.y] += BIT_EAST
	
	# Bossraum
	boss_room_x = current_position.x
	boss_room_y = current_position.y

func _create_room_list(path: String) -> void:
	var directory = DirAccess.open(path)
	if directory == null:
		push_error("Konnte Ordner nicht öffnen: %s" % path)
		return

	directory.list_dir_begin()
	var file_name = directory.get_next()
	while file_name != "":
		if not directory.current_is_dir():
			var absolute_path = directory.get_current_dir().path_join(file_name)
			room_list.append(absolute_path)
		file_name = directory.get_next()
	directory.list_dir_end()

func _get_random_room(type: int):
	# alle räume des types in einer liste
	var possible_rooms = []
	for room in room_list:
		var file_name = room.get_file()
		var number = file_name.split("_")
		if number.size() > 0:
			if int(number[0]) == type:
				possible_rooms.append(room)
	if possible_rooms:
		return possible_rooms.pick_random()
	else:
		return null

func _fill_map(initial_room: String):
	# Räume random auswählen
	for x in WIDTH:
		for y in HEIGHT:
			if dungeon_grid[x][y] != 0:
				var room_type = dungeon_grid[x][y]
				dungeon_grid[x][y] = _get_random_room(room_type)
	
	# Erster Raum
	dungeon_grid[first_room_x][first_room_y] = initial_room
	# Boss Raum
	dungeon_grid[boss_room_x][boss_room_y] = initial_room
	
func get_room_path(coor: Vector2i):
	return dungeon_grid[coor.x][coor.y]
