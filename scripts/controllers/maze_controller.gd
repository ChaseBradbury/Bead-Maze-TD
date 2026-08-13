extends Node3D
class_name MazeController

@export var bead_scene = load("res://scenes/bead.tscn")
@export var bead_interval = 1.0

var queued_beads: Array[BeadController] = []
var beads: Array[BeadController] = []
var time_elapsed: float = 0.0
var queue_stuck: bool = false

signal bead_finished(bead_value: Bead)
signal bead_killed(bead_value: Bead)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_elapsed += delta
	if time_elapsed > bead_interval:
		time_elapsed = 0.0
		var bead_node = bead_scene.instantiate()
		bead_node.finished.connect(_on_bead_finished)
		bead_node.killed.connect(_on_bead_killed)
		$QueuePath.add_child(bead_node)
		queued_beads.append(bead_node)
	queue_stuck = false
	for bead in queued_beads:
		if not bead.is_movable():
			queue_stuck = true

func _on_bead_finished(bead_node: BeadController):
	if bead_node.in_queue:
		queued_beads.erase(bead_node)
		beads.append(bead_node)
		$QueuePath.remove_child(bead_node)
		$MainPath.add_child(bead_node)
		bead_node.progress = 0
		bead_node.in_queue = false

func _on_bead_killed(bead_node: BeadController):
	bead_killed.emit(bead_node.bead)
	beads.erase(bead_node)
	bead_node.queue_free()

func get_first_bead() -> BeadController:
	return beads.front()

func get_last_bead() -> BeadController:
	return beads.back()

func get_closest_bead(global_pos: Vector3) -> BeadController:
	var closest: BeadController = get_first_bead()
	if closest == null:
		return null
	var closest_dist: float = closest.global_position.distance_to(global_pos)
	for bead in beads:
		if bead.global_position.distance_to(global_pos) < closest_dist:
			closest_dist = bead.global_position.distance_to(global_pos)
			closest = bead
	return closest
