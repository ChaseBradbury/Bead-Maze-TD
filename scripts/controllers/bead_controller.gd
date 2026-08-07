extends Area3D
class_name BeadController

@export var path_follow: PathFollow3D
@export var bead: Bead = load("res://resources/beads/red_bead.tres")

var current_health: int

var frozen: bool = false

signal finished(bead_node: BeadController)
signal killed(bead_node: BeadController)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = bead.health
	update_health_color()
	update_health_scale()
	$Healthbar.set_max_health(current_health)
	$Healthbar.set_health(current_health)
	GameManager.state_changed.connect(_on_state_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_movable():
		path_follow.progress += bead.speed * delta

func update_health_color():
	var mesh_mat = $Mesh.get_active_material(0)
	mesh_mat.albedo_color = bead.health_gradient.sample(float(current_health)/bead.health)

func update_health_scale():
	var health_ratio = float(current_health)/bead.health
	var new_scale = bead.scale_min + health_ratio*(bead.scale_max - bead.scale_min)
	print(new_scale)
	scale = Vector3(new_scale, new_scale, new_scale)



func is_movable() -> bool:
	if frozen:
		return false
	if path_follow.progress_ratio >= 1.0:
		return false
	return true

func hit(projectile: Projectile):
	current_health -= projectile.damage
	$Healthbar.set_health(current_health)
	update_health_color()
	update_health_scale()
	if current_health <= 0:
		killed.emit(self)

func _on_state_changed(state: GameManager.State):
	if state == GameManager.State.IDLE:
		input_ray_pickable = true
	else:
		input_ray_pickable = false


func _on_front_area_entered(area: Area3D) -> void:
	frozen = true


func _on_front_area_exited(area: Area3D) -> void:
	frozen = false
