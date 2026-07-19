extends Control
class_name TowerButton

@export var tower: Tower

signal pressed(tower: Tower)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button.text = "Buy " + tower.name + ": " + str(tower.cost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	pressed.emit(tower)
