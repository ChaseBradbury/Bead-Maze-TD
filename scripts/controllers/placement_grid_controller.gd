extends Node3D

@export var point_scene = load("res://scenes/placement_point.tscn")
@export var column_scene = load("res://scenes/placement_column.tscn")
@export var tower_scene = load("res://scenes/tower.tscn")
@export var size: Vector3i = Vector3i(15, 5, 15)
@export var spacing: Vector3 = Vector3(15, 15, 15)
@export var mazes: Array[MazeController]
@export var idle_color: Color
@export var hover_color: Color
@export var pressed_color: Color

var tower_to_place: Tower
var columns = []
var tower_matrix = []

signal tower_placed(tower: Tower)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var world_offset: Vector3
	world_offset.x = -(size.x * spacing.x)/2
	world_offset.y = 0
	world_offset.z = -(size.z * spacing.z)/2
	for x in size.x:
		columns.append([])
		for z in size.z:
			var column_node = column_scene.instantiate()
			column_node.position.x = (spacing.x * x) + world_offset.x
			column_node.position.y = world_offset.y
			column_node.position.z = (spacing.z * z) + world_offset.z
			column_node.idle_color = idle_color
			column_node.hover_color = hover_color
			column_node.pressed_color = pressed_color
			column_node.set_spacing(spacing, size.y)
			column_node.column_coords = Vector3i(x, 0, z)
			column_node.point_released.connect(_on_point_released)
			add_child(column_node)
	for x in size.x:
		tower_matrix.append([])
		for y in size.y:
			tower_matrix[x].append([])
			for z in size.z:
				tower_matrix[x][y].append(null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_tower_to_place(tower: Tower):
	tower_to_place = tower

func _on_point_released(coords: Vector3i, world_pos: Vector3):
	var tower_node = tower_scene.instantiate()
	tower_node.position = world_pos
	tower_matrix[coords.x][coords.y][coords.z] = tower_node
	tower_node.mazes = mazes
	tower_node.tower = tower_to_place
	add_child(tower_node)
	tower_placed.emit(tower_to_place)
	GameManager.set_state(GameManager.State.IDLE)
