extends Node3D

var target = null

var head_speed: float = TAU * 2
var cannon_speed: float = TAU/2
var cannon_max_angle: float = 35
var cannon_min_angle: float = -10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not target == null:
		var target_direction = $Elements/Head.global_position.direction_to(target.global_position)
		var head_rotation = $Elements/Head.rotation
		var cannon_rotation = $Elements/Head/CannonContainer.rotation
		var cannon_target_angle = clamp(Vector2(target_direction.x, target_direction.y).angle(), deg_to_rad(cannon_min_angle), deg_to_rad(cannon_max_angle))
		$Elements/Head.rotation.y = rotate_toward(head_rotation.y, Vector2(target_direction.x, -target_direction.z).angle(), head_speed*delta)
		$Elements/Head/CannonContainer.rotation.z = rotate_toward(cannon_rotation.z, cannon_target_angle, cannon_speed*delta)
		

func set_target(new_target: BeadController):
	target = new_target
