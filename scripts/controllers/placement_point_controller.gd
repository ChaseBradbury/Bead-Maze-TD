extends Node3D

var matrix_coords: Vector3i

signal point_pressed(coords: Vector3i, world_pos: Vector3)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_coords(new_coords: Vector3i):
	matrix_coords = new_coords

func _on_point_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				point_pressed.emit(matrix_coords, position)


func _on_point_area_mouse_entered() -> void:
	$PointMesh.scale = Vector3(2, 2, 2)
	$AxisIndicators.visible = true


func _on_point_area_mouse_exited() -> void:
	$PointMesh.scale = Vector3(1, 1, 1)
	$AxisIndicators.visible = false
