extends Node2D

signal exit_room(direction)
signal player_died

enum direction {NORTH=1, EAST=2, SOUTH=3, WEST=4}

var is_player_died = false
var player_exit = 0

@export var debug_start : direction = direction.NORTH
@onready var fade_screen: UiFadeScreen = %fade_screen
@onready var tilemap_game_data: TileMapLayer = $tilemap_game_data
@onready var astronaut_2d: PlayerAstronaut = $astronaut_2d

func _ready() -> void:
	get_tree().paused = false
	fade_screen.visible = true
	fade_screen.fade_in()
	tilemap_game_data.visible = false
	
	# fuer debug
	if get_parent() == get_tree().root:
		initialize(debug_start)

func _process(delta: float) -> void:
	# überpruefung ob player ein exit erreicht hat 
	var current_player_coor = tilemap_game_data.local_to_map(astronaut_2d.global_position)
	var tile_data = tilemap_game_data.get_cell_tile_data(current_player_coor)
	if tile_data:
		var exit_id = tile_data.get_custom_data("exits")
		if exit_id:
			#print(exit_id)
			player_exit = exit_id
			get_tree().paused = true
			fade_screen.fade_out()
			
func initialize(dir: direction):
	var spawn_pos = get_spawn_point(dir)
	astronaut_2d.position = spawn_pos
	if dir == direction.EAST:
		astronaut_2d.quick_direction(astronaut_2d.QUICK_DIR.LEFT)
	else:
		astronaut_2d.quick_direction(astronaut_2d.QUICK_DIR.RIGHT)
		
func get_spawn_point(dir: direction) -> Vector2:
	for coords in tilemap_game_data.get_used_cells():
		var tile = tilemap_game_data.get_cell_tile_data(coords)
		if tile:
			var spawn_id = tile.get_custom_data("spawn_points")
			if spawn_id == dir:
				return tilemap_game_data.map_to_local(coords)
	return Vector2.ZERO
	
func _on_astronaut_2d_died() -> void:
	is_player_died = true
	fade_screen.fade_out()

func _on_fade_screen_fade_out_completed() -> void:
	if player_exit > 0:
		exit_room.emit(player_exit)
	elif is_player_died == true: 
		player_died.emit()
	# Debug falls es keinen parent gibt
	if get_parent() == get_tree().root:
		get_tree().reload_current_scene()
