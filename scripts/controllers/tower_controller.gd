extends Node3D

@export var projectile_scene = load("res://scenes/projectile.tscn")
@export var tower: Tower = load("res://resources/towers/yellow_tower.tres")
@export var mazes: Array[MazeController]

var time_elapsed: float = 0.0
var tower_model_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mesh_mat = $Mesh.get_active_material(0)
	mesh_mat.albedo_color = tower.color
	var tower_model_scene = Constants.TOWER_MODEL_SCENES[tower.model_scene_index].instantiate()
	add_child(tower_model_scene)
	tower_model_node = tower_model_scene
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target = mazes[0].get_closest_bead(global_position)
	tower_model_node.set_target(target)
	time_elapsed += delta
	if time_elapsed > tower.attack_speed:
		time_elapsed = 0.0
		var projectile_node = projectile_scene.instantiate()
		projectile_node.target_node = target
		projectile_node.projectile = tower.projectile
		add_child(projectile_node)
