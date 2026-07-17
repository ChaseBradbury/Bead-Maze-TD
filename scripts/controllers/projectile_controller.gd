extends Area3D

var target_node: Node3D
var target_direction: Vector3
var projectile: Projectile

var time_elapsed: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_direction()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_elapsed += delta
	if projectile.homing:
		if not is_instance_valid(target_node):
			queue_free()
			return
		update_direction()
	look_at(target_direction)
	position += target_direction * delta * projectile.speed
	
	if time_elapsed >= projectile.lifespan:
		queue_free()

func update_direction():
	target_direction = global_position.direction_to(target_node.global_position)

func _on_area_entered(bead: BeadController) -> void:
	bead.hit(projectile)
	queue_free()
