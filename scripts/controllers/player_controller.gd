extends Node3D

@export var tilt_speed: float = 3.0
@export var rotation_speed: float = 5.0
@export var zoom_increment: float = 5.0
var camera_speed = 0.00005
@export var camera_zoom: float = 150.0
@export var camera_zoom_min: float = 100.0
@export var camera_zoom_max: float = 200.0
@export var camera_tilt_min: float = -0.1
@export var camera_tilt_max: float = -1.3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CameraAnchor/Camera.position.z = camera_zoom
	$CameraAnchor.rotation.x = (camera_tilt_min+camera_tilt_max)/2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("zoom_out"):
		$CameraAnchor/Camera.position.z += zoom_increment
		if $CameraAnchor/Camera.position.z > camera_zoom_max:
			$CameraAnchor/Camera.position.z = camera_zoom_max
	if Input.is_action_pressed("zoom_in"):
		$CameraAnchor/Camera.position.z -= zoom_increment
		if $CameraAnchor/Camera.position.z < camera_zoom_min:
			$CameraAnchor/Camera.position.z = camera_zoom_min
	if Input.is_action_pressed("camera_right"):
		rotate_y(rotation_speed * delta)
	if Input.is_action_pressed("camera_left"):
		rotate_y(-rotation_speed * delta)
	if Input.is_action_pressed("camera_up"):
		$CameraAnchor.rotate_x(-tilt_speed * delta)
		if $CameraAnchor.rotation.x < camera_tilt_max:
			$CameraAnchor.rotation.x = camera_tilt_max
	if Input.is_action_pressed("camera_down"):
		$CameraAnchor.rotate_x(tilt_speed * delta)
		if $CameraAnchor.rotation.x > camera_tilt_min:
			$CameraAnchor.rotation.x = camera_tilt_min

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		return
		$Camera.rotation.x += event.relative.y
		$Camera.rotation.y += event.relative.x
