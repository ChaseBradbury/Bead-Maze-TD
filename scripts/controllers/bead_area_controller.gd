extends Area3D
class_name BeadAreaController

signal collided(effects: Array[Effect])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hit(effects: Array[Effect]):
	collided.emit(effects)
