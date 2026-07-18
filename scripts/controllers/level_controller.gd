extends Node3D

@export var lives: int = 100
@export var money: int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_lives_ui()
	update_money_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_lives_ui():
	$GameInfo/Lives.text = "Lives: " + str(lives)
	
func update_money_ui():
	$GameInfo/Money.text = "Money: " + str(money)


func _on_maze_bead_finished(bead_value: Bead) -> void:
	lives -= 1
	update_lives_ui()


func _on_button_pressed() -> void:
	GameManager.set_state(GameManager.State.PLACING)


func _on_floor_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			GameManager.set_state(GameManager.State.IDLE)
			
