extends Node3D
class_name TowerController

@export var projectile_scene = load("res://scenes/projectile.tscn")
@export var tower: Tower = load("res://resources/towers/yellow_tower.tres")
@export var mazes: Array[MazeController]

var time_elapsed: float = 0.0
var tower_model_node

var targeting_mode: Constants.Targeting = Constants.Targeting.CLOSEST
var is_selected: bool = false

signal tower_pressed(tower_controller: TowerController)
signal tower_released(tower_controller: TowerController)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var mesh_mat = $SelectionMesh.get_active_material(0)
	#mesh_mat.albedo_color = tower.color
	var tower_model_scene = Constants.TOWER_MODEL_SCENES[tower.model_scene_index].instantiate()
	tower_model_scene.set_tower(tower)
	add_child(tower_model_scene)
	tower_model_node = tower_model_scene
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target: BeadController
	match(targeting_mode):
		Constants.Targeting.CLOSEST:
			target = mazes[0].get_closest_bead(global_position)
		Constants.Targeting.FIRST:
			target = mazes[0].get_first_bead()
		Constants.Targeting.LAST:
			target = mazes[0].get_last_bead()
	tower_model_node.set_target(target)
	time_elapsed += delta
	if time_elapsed > tower.attack_speed:
		time_elapsed = 0.0
		var projectile_node = projectile_scene.instantiate()
		projectile_node.target_node = target
		projectile_node.projectile = tower.projectile
		add_child(projectile_node)


func _on_selection_area_mouse_entered() -> void:
	$SelectionMesh.visible = true


func _on_selection_area_mouse_exited() -> void:
	if not is_selected:
		$SelectionMesh.visible = false


func _on_selection_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				tower_pressed.emit(self)
		else:
			if event.button_index == MOUSE_BUTTON_LEFT:
				tower_released.emit(self)
				is_selected = true

func deselect():
	is_selected = false
	$SelectionMesh.visible = false
