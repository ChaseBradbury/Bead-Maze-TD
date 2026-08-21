extends PathFollow3D
class_name BeadController

@export var bead: Bead = load("res://resources/beads/red_bead.tres")

var current_health: int

var frozen: bool = false
var in_queue: bool = true

var speed_modifier: float

var effects: Array[Effect]

signal finished(bead_node: BeadController)
signal killed(bead_node: BeadController)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loop = false
	current_health = bead.health
	update_health_color()
	update_health_scale()
	$Healthbar.set_max_health(current_health)
	$Healthbar.set_health(current_health)
	GameManager.state_changed.connect(_on_state_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed_modifier = 1.0
	for effect in effects:
		effect.process_effect(self, delta)
	if progress_ratio >= 1.0:
		finished.emit(self)
	if is_movable():
		progress += bead.speed *speed_modifier * delta

func update_health_color():
	var mesh_mat = $BeadArea/Mesh.get_active_material(0)
	mesh_mat.albedo_color = bead.health_gradient.sample(float(current_health)/bead.health)

func update_health_scale():
	var health_ratio = float(current_health)/bead.health
	var new_scale = bead.scale_min + health_ratio*(bead.scale_max - bead.scale_min)
	$BeadArea.scale = Vector3(new_scale, new_scale, new_scale)



func is_movable() -> bool:
	if frozen:
		return false
	if progress_ratio >= 1.0:
		return false
	return true


func _on_state_changed(state: GameManager.State):
	if state == GameManager.State.IDLE:
		$BeadArea.input_ray_pickable = true
	else:
		$BeadArea.input_ray_pickable = false


func _on_front_area_entered(area: Area3D) -> void:
	frozen = true


func _on_front_area_exited(area: Area3D) -> void:
	frozen = false


func _on_bead_area_collided(projectile: Projectile) -> void:
	for p_effect in projectile.effects:
		p_effect.initialize_effect(self)
		effects.append(p_effect.duplicate())

func damage(amount: int):
	current_health -= amount
	$Healthbar.set_health(current_health)
	update_health_color()
	update_health_scale()
	if current_health <= 0:
		killed.emit(self)
