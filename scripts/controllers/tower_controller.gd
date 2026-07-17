extends Node3D

@export var projectile_scene = load("res://scenes/projectile.tscn")
@export var tower: Tower = load("res://resources/towers/yellow_tower.tres")
@export var mazes: Array[MazeController]

var time_elapsed: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mesh_mat = $Mesh.get_active_material(0)
	mesh_mat.albedo_color = tower.color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_elapsed += delta
	if time_elapsed > tower.attack_speed:
		time_elapsed = 0.0
		var projectile_node = projectile_scene.instantiate()
		projectile_node.target_node = mazes[0].get_closest_bead(global_position)
		projectile_node.projectile = tower.projectile
		add_child(projectile_node)
