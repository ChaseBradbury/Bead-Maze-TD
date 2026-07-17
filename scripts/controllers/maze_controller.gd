extends Node3D

@export var bead_scene = load("res://scenes/bead.tscn")
@export var bead_num = 10
@export var bead_interval = 1.0

var created_beads = 0
var time_elapsed: float = 0.0

signal bead_finished(bead_value: Bead)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_elapsed += delta
	if time_elapsed > bead_interval and created_beads < bead_num:
		time_elapsed = 0.0
		var path_follow_node = PathFollow3D.new()
		var bead_node = bead_scene.instantiate()
		bead_node.path_follow = path_follow_node
		bead_node.finished.connect(_on_bead_finished)
		path_follow_node.loop = false
		path_follow_node.add_child(bead_node)
		$Path.add_child(path_follow_node)
		created_beads += 1

func _on_bead_finished(bead: Bead):
	bead_finished.emit(bead)
