extends Area3D
class_name ProjectileController

var target_node: Node3D
var target_direction: Vector3
var target_position: Vector3
var projectile: Projectile
var effects: Array[Effect]

var time_elapsed: float = 0.0
var collided_beads: Array[BeadAreaController]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_direction()
	$CollisionShape3D.scale = Vector3(projectile.impact_radius, projectile.impact_radius, projectile.impact_radius)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_elapsed += delta
	if projectile.homing:
		if not is_instance_valid(target_node):
			queue_free()
			return
		update_direction()
	look_at(target_direction)
	global_position += target_direction * delta * projectile.speed
	if global_position.distance_to(target_position) < projectile.tolerance and time_elapsed > delta:
		global_position = target_position
		impact()
	if time_elapsed >= projectile.lifespan:
		queue_free()

func update_direction():
	if is_instance_valid(target_node):
		target_position = target_node.global_position
		target_direction = global_position.direction_to(target_node.global_position)

func impact():
	$CollisionShape3D.scale = Vector3(projectile.impact_radius, projectile.impact_radius, projectile.impact_radius)
	for bead in collided_beads:
		bead.hit(effects)
	queue_free()

func _on_area_entered(bead: BeadAreaController) -> void:
	collided_beads.append(bead)
	if projectile.impact_on_first_collision:
		global_position = bead.global_position
		impact()

func _on_area_exited(bead: BeadAreaController) -> void:
	collided_beads.erase(bead)
