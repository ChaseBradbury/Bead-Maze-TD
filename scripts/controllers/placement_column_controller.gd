extends Node3D

@export var point_scene = load("res://scenes/placement_point.tscn")
@export var idle_color: Color
@export var hover_color: Color
@export var pressed_color: Color

var num_points: int
var spacing: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GroundMesh.get_active_material(0).albedo_color = idle_color
	for y in num_points:
		var point_node = point_scene.instantiate()
		point_node.position.y = spacing.y * (y+1)
		#point_node.set_coords(Vector3i(x,y,z))
		#point_node.point_pressed.connect(_on_point_pressed)
		#point_matrix[x][y].append(point_node)
		#tower_matrix[x][y].append(null)
		$Points.add_child(point_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_spacing(new_spacing: Vector3, points: int):
	num_points = points
	spacing = new_spacing
	$GroundArea.scale.x = spacing.x
	$GroundArea.scale.z = spacing.z
	$GroundMesh.scale.x = spacing.x
	$GroundMesh.scale.z = spacing.z
	$ColumnMesh.scale.y = spacing.y * num_points
	$ColumnMesh.position.y = (spacing.y * num_points)/2
	$ColumnArea.scale.y = spacing.y * num_points
	$ColumnArea.position.y = (spacing.y * num_points)/2

func focus_column():
	$GroundMesh.get_active_material(0).albedo_color = hover_color
	$ColumnMesh.visible = true
	$Points.visible = true

func blur_column():
	$GroundMesh.get_active_material(0).albedo_color = idle_color
	$ColumnMesh.visible = false
	$Points.visible = false

func _on_area_mouse_entered() -> void:
	if GameManager.is_state(GameManager.State.PLACING):
		focus_column()


func _on_area_mouse_exited() -> void:
	if not GameManager.is_state(GameManager.State.DRAGGING):
		blur_column()


func _on_ground_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if GameManager.is_state(GameManager.State.PLACING):
					GameManager.set_state(GameManager.State.DRAGGING)
			if event.button_index == MOUSE_BUTTON_RIGHT:
				blur_column()
				if GameManager.is_state(GameManager.State.DRAGGING):
					GameManager.set_state(GameManager.State.IDLE)
