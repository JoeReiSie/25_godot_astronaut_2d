extends Node

enum direction {NORTH=1, EAST=2, SOUTH=3, WEST=4}
const START_ROOM = "res://game/rooms/4_start_plattform.tscn"
var current_position : Vector2i = Vector2i(3, 0)
var current_scene: Node = null
var current_scene_path: String = ""
var current_direction = null
var create_new_dungeon : bool = true
@onready var dungeon_generator: DungeonGenerator = $dungeon_generator 


func _ready() -> void:
	dungeon_generator.create_dungeon(80)
	var first_room = dungeon_generator.get_room_path(current_position)
	change_scene(first_room, direction.NORTH)
	
func change_scene(path: String, dir: direction) -> void:
	# Bestehende Scene loeschen
	if current_scene:
		current_scene.queue_free()

	# Neue szene erstellen
	var new_scene = load(path).instantiate()
	add_child(new_scene)
	new_scene.exit_room.connect(_on_room_exit)
	new_scene.player_died.connect(_on_player_died)
	new_scene.initialize(dir)
	current_scene = new_scene
	current_scene_path = path
	current_direction = dir
	
func _on_room_exit(dir: direction):
	# neuen raum laden 
	if dir == direction.NORTH:
		current_position.y -= 1
	if dir == direction.EAST:
		current_position.x += 1
	if dir == direction.SOUTH:
		current_position.y += 1
	if dir == direction.WEST:
		current_position.x -= 1
	
	var new_room_path = dungeon_generator.get_room_path(current_position)
	print(new_room_path)
	change_scene(new_room_path, get_opposite_side(dir))
	
	print(dungeon_generator.get_room_type(current_position))
	if dungeon_generator.get_room_type(current_position) == 90:
		# TODO: aktueller bossraum muss irgendwie übergeben werden können und current_position fixen
		dungeon_generator.create_dungeon(90)
		current_position = Vector2i(3, 0)

func get_opposite_side(dir: direction):
	if dir == direction.NORTH:
		return direction.SOUTH
	if dir == direction.EAST:
		return direction.WEST
	if dir == direction.SOUTH:
		return direction.NORTH
	if dir == direction.WEST:
		return direction.EAST


func _on_player_died():
	#print("Died")
	change_scene(current_scene_path, current_direction)
