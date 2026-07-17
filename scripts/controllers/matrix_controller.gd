extends Node3D

@export var point_scene = load("res://scenes/placement_point.tscn")
@export var tower_scene = load("res://scenes/tower.tscn")
@export var size: Vector3i = Vector3i(5, 5, 5)
@export var spacing: Vector3 = Vector3(25, 25, 25)
@export var mazes: Array[MazeController]

var point_matrix = []
var tower_matrix = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var world_offset: Vector3
	world_offset.x = -(size.x * spacing.x)/2
	world_offset.y = 0
	world_offset.z = -(size.z * spacing.z)/2
	for x in size.x:
		point_matrix.append([])
		tower_matrix.append([])
		for y in size.y:
			point_matrix[x].append([])
			tower_matrix[x].append([])
			for z in size.z:
				var point_node = point_scene.instantiate()
				point_node.position.x = (spacing.x * x) + world_offset.x
				point_node.position.y = (spacing.y * y) + world_offset.y
				point_node.position.z = (spacing.z * z) + world_offset.z
				add_child(point_node)
				point_node.set_coords(Vector3i(x,y,z))
				point_node.point_pressed.connect(_on_point_pressed)
				point_matrix[x][y].append(point_node)
				tower_matrix[x][y].append(null)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_point_pressed(coords: Vector3i, world_pos: Vector3):
	var tower_node = tower_scene.instantiate()
	tower_node.position = world_pos
	tower_matrix[coords.x][coords.y][coords.z] = tower_node
	tower_node.mazes = mazes
	add_child(tower_node)
