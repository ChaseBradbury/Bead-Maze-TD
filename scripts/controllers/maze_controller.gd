extends Node3D
class_name MazeController

@export var bead_scene = load("res://scenes/bead.tscn")
@export var bead_num = 10
@export var bead_interval = 1.0

var beads: Array[BeadController] = []
var time_elapsed: float = 0.0

signal bead_finished(bead_value: Bead)
signal bead_killed(bead_value: Bead)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_elapsed += delta
	if time_elapsed > bead_interval and beads.size() < bead_num:
		time_elapsed = 0.0
		var path_follow_node = PathFollow3D.new()
		var bead_node = bead_scene.instantiate()
		bead_node.path_follow = path_follow_node
		bead_node.finished.connect(_on_bead_finished)
		bead_node.killed.connect(_on_bead_killed)
		path_follow_node.loop = false
		path_follow_node.add_child(bead_node)
		$Path.add_child(path_follow_node)
		beads.append(bead_node)

func _on_bead_finished(bead_node: BeadController):
	bead_finished.emit(bead_node.bead)
	beads.erase(bead_node)
	bead_node.path_follow.queue_free()

func _on_bead_killed(bead_node: BeadController):
	bead_killed.emit(bead_node.bead)
	beads.erase(bead_node)
	bead_node.path_follow.queue_free()

func get_first_bead() -> BeadController:
	return beads.front()

func get_last_bead() -> BeadController:
	return beads.back()

func get_closest_bead(global_pos: Vector3) -> BeadController:
	var closest: BeadController = get_first_bead()
	var closest_dist: float = closest.global_position.distance_to(global_pos)
	for bead in beads:
		if bead.global_position.distance_to(global_pos) < closest_dist:
			closest_dist = bead.global_position.distance_to(global_pos)
			closest = bead
	return closest
