class_name DungeonGenerator
extends Node

const PATH_LENGHT = 7
const WIDTH = 7
const HEIGHT = PATH_LENGHT
const BIT_NORTH = 1
const BIT_EAST = 2
const BIT_SOUTH = 4
const BIT_WEST = 8

var dungeon_grid = []
var current_coor : Vector2i
var dir = 0
var room_list = []
#var first_debug_room = "res://game/rooms/4_start_plattform.tscn"
var first_debug_room = 80
var first_room_coor : Vector2i
var boss_room_coor : Vector2i
var rng =RandomNumberGenerator.new()

class RoomData:
	var type: int
	var path: String

func _ready() -> void:
	create_dungeon(first_debug_room)

func create_dungeon(initial_room_type: int):
	# Beim start wird ein dungeon generiert, der erste raum wird per parameter übergeben
	_create_dungeon_array()
	_set_coor(3, 0)
	_generate_map()
	_create_room_list("res://game/rooms/")
	_fill_map(initial_room_type)
	_set_coor(3, 0)
	
	#for x in WIDTH:
		#print("________________________")
		#for y in HEIGHT:
			#print(dungeon_grid[x][y].type)
	
func _create_dungeon_array():
	# array löschen und grundgerüst erzeugen
	dungeon_grid.clear()
	for x in WIDTH:
		dungeon_grid.append([])
		for y in HEIGHT:
			dungeon_grid[x].append(RoomData.new())
		
func _set_coor(x, y):
	current_coor = Vector2i(x, y)
	
func _generate_map():
	# Erster Raum
	first_room_coor = current_coor
	
	var lenght : int = 1
	# Pfad erstellen
	while lenght < PATH_LENGHT:
		# zufaellig eine richtung auswaehlen
		if lenght == 1 or lenght == PATH_LENGHT:
			dir = 2
		else :
			dir = rng.randi_range(1,3)
		
		if dir == 1:
			# ost
			if current_coor.x < WIDTH-1:
				if dungeon_grid[current_coor.x + 1][current_coor.y].type == 0:
					dungeon_grid[current_coor.x][current_coor.y].type += BIT_EAST
					current_coor.x += 1
					lenght += 1
					dungeon_grid[current_coor.x][current_coor.y].type += BIT_WEST
		elif dir == 2:
			# sued
			if current_coor.y < HEIGHT-1:
				if dungeon_grid[current_coor.x][current_coor.y + 1].type == 0:
					dungeon_grid[current_coor.x][current_coor.y].type += BIT_SOUTH
					current_coor.y += 1
					lenght += 1
					dungeon_grid[current_coor.x][current_coor.y].type += BIT_NORTH
		elif dir == 3:
			# west
			if current_coor.x > 0:
				if dungeon_grid[current_coor.x - 1][current_coor.y].type == 0:
					dungeon_grid[current_coor.x][current_coor.y].type += BIT_WEST 
					current_coor.x -= 1
					lenght += 1
					dungeon_grid[current_coor.x][current_coor.y].type += BIT_EAST
	
	# Bossraum
	boss_room_coor = current_coor

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
	# alle räume eines types in eine liste packen
	# der raum datei name muss mit der typ nummer beginnen
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
		return ""

func _fill_map(initial_room_type: int):
	# Räume random auswählen
	for x in WIDTH:
		for y in HEIGHT:
			if dungeon_grid[x][y].type != 0:
				var room_type = dungeon_grid[x][y].type
				dungeon_grid[x][y].path = _get_random_room(room_type)
	
	# Erster Raum
	dungeon_grid[first_room_coor.x][first_room_coor.y].path = _get_random_room(initial_room_type)
	dungeon_grid[first_room_coor.x][first_room_coor.y].type = initial_room_type
	# Boss Raum
	dungeon_grid[boss_room_coor.x][boss_room_coor.y].path = _get_random_room(90)
	dungeon_grid[boss_room_coor.x][boss_room_coor.y].type = 90
	
func get_room_path(coor: Vector2i):
	return dungeon_grid[coor.x][coor.y].path
	
func get_room_type(coor: Vector2i):
	return dungeon_grid[coor.x][coor.y].type
