extends Node3D

@export var path_follow: PathFollow3D
@export var bead: Bead = load("res://resources/beads/red_bead.tres")

signal finished(bead_value: Bead)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mesh_color = $Mesh.get_active_material(0)
	mesh_color.albedo_color = bead.color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.progress += bead.speed * delta
	if path_follow.progress_ratio >= 1.0:
		finished.emit(bead)
		path_follow.queue_free()
