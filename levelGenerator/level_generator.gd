extends Node2D

@onready var tilemap: TileMap = $TileMap

const MAP_WIDTH = 100
const MAP_HEIGHT = 100
const MAX_ROOMS = 10
const ROOM_MIN_SIZE = 5
const ROOM_MAX_SIZE = 12

var rooms = []

func _ready():
	generate_level()

func generate_level():
	randomize()
	for i in MAX_ROOMS:
		var room_width = randi_range(ROOM_MIN_SIZE, ROOM_MAX_SIZE)
		var room_height = randi_range(ROOM_MIN_SIZE, ROOM_MAX_SIZE)
		var x = randi_range(0, MAP_WIDTH - room_width)
		var y = randi_range(0, MAP_HEIGHT - room_height)

		var room = Rect2(x, y, room_width, room_height)

		# Check for room overlap
		var overlaps = false
		for other in rooms:
			if room.intersects(other.grow(1)):
				overlaps = true
				break
		if overlaps:
			continue

		rooms.append(room)
		draw_room(room)

	connect_rooms()

func draw_room(room: Rect2):
	for x in int(room.position.x) : int(room.position.x + room.size.x):
		for y in int(room.position.y) : int(room.position.y + room.size.y):
			tilemap.set_cell(0, Vector2i(x, y), 0) # 0 = floor tile index

func connect_rooms():
	for i in range(1, rooms.size()):
		var room_a = rooms[i - 1].get_center()
		var room_b = rooms[i].get_center()
		var start = Vector2i(room_a)
		var end = Vector2i(room_b)

		# Simple L-shaped corridor
		for x in range(min(start.x, end.x), max(start.x, end.x) + 1):
			tilemap.set_cell(0, Vector2i(x, start.y), 0)
		for y in range(min(start.y, end.y), max(start.y, end.y) + 1):
			tilemap.set_cell(0, Vector2i(end.x, y), 0)
			
func go_to_next_floor():
	tilemap.clear()
	rooms.clear()
	generate_level()
