extends Node3D

@export var max_health = 100
@export var current_health = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_max_health(value: int):
	max_health = value
	$SubViewport/ProgressBar.max_value = max_health

func set_health(value: int):
	current_health = value
	$SubViewport/ProgressBar.value = current_health
