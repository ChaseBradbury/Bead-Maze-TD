extends Node3D

@export var lives: int = 100
@export var money: int = 100
@export var warning_time: float = 2

var warning_time_elapsed: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_lives_ui()
	update_money_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	warning_time_elapsed += delta
	if warning_time_elapsed > warning_time:
		$Warning.visible = false
	

func update_lives_ui():
	$GameInfo/Lives.text = "Lives: " + str(lives)
	
func update_money_ui():
	$GameInfo/Money.text = "Money: " + str(money)

func warn(text: String):
	$Warning.text = text
	$Warning.visible = true
	warning_time_elapsed = 0

func _on_maze_bead_finished(bead: Bead) -> void:
	lives -= 1
	update_lives_ui()


func _on_button_pressed() -> void:
	GameManager.set_state(GameManager.State.PLACING)


func _on_floor_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			GameManager.set_state(GameManager.State.IDLE)
			


func _on_maze_bead_killed(bead: Bead) -> void:
	money += bead.bounty
	update_money_ui()


func _on_tower_button_pressed(tower: Tower) -> void:
	if money >= tower.cost:
		$PlacementGrid.set_tower_to_place(tower)
		GameManager.set_state(GameManager.State.PLACING)
	else:
		warn("Not enough money!")
		


func _on_placement_grid_tower_placed(tower: Tower) -> void:
	money -= tower.cost
	update_money_ui()
