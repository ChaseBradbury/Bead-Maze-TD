extends Node3D
class_name TowerModelController

var target = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Elements/top.rotate_y(delta)
	if not target == null:
		$Elements/CannonContainer.look_at(target.global_position)

func set_target(new_target: BeadController):
	target = new_target
