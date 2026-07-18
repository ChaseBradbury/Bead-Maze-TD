extends Area3D
class_name BeadController

@export var path_follow: PathFollow3D
@export var bead: Bead = load("res://resources/beads/red_bead.tres")

var current_health

signal finished(bead_node: BeadController)
signal killed(bead_node: BeadController)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mesh_mat = $Mesh.get_active_material(0)
	mesh_mat.albedo_color = bead.color
	current_health = bead.health
	$Healthbar.set_max_health(current_health)
	$Healthbar.set_health(current_health)
	GameManager.state_changed.connect(_on_state_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.progress += bead.speed * delta
	if path_follow.progress_ratio >= 1.0:
		finished.emit(self)

func hit(projectile: Projectile):
	current_health -= projectile.damage
	$Healthbar.set_health(current_health)
	if current_health <= 0:
		killed.emit(self)

func _on_state_changed(state: GameManager.State):
	if state == GameManager.State.IDLE:
		input_ray_pickable = true
	else:
		input_ray_pickable = false
