extends Node3D

var speed = 10
var camera_speed = 0.00005
@export var camera_z_offset: float = 500.0
@export var camera_x_rotate_min: float = 0.0
@export var camera_x_rotate_max: float = 0.8


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera.position.z = camera_z_offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_down"):
		position.z -= 100
	if Input.is_action_pressed("camera_right"):
		rotate_y(speed * delta)
	if Input.is_action_pressed("camera_left"):
		rotate_y(-speed * delta)
	if Input.is_action_pressed("camera_up"):
		rotate_x(-speed * delta)
		if rotation.x < camera_x_rotate_min:
			rotation.x = camera_x_rotate_min
	if Input.is_action_pressed("camera_down"):
		rotate_x(speed * delta)
		if rotation.x > camera_x_rotate_max:
			rotation.x = camera_x_rotate_max

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		return
		$Camera.rotation.x += event.relative.y
		$Camera.rotation.y += event.relative.x
