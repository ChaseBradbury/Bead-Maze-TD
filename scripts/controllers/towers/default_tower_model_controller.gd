extends TowerModelBase

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TowerMesh.mesh.material.albedo_color = tower.color
