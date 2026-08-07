extends Node3D

@export var notification_scene = load("res://scenes/ui/notification.tscn")
@export var lives: int = 100
@export var money: int = 100
@export var max_notifications: int = 5

var selected_tower: TowerController

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_lives_ui()
	update_money_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func update_lives_ui():
	$GameInfo/Lives.text = "Lives: " + str(lives)
	if lives <= 5:
		notify(str(lives) + " lives left!", Notification.Type.WARNING)
	
func update_money_ui():
	$GameInfo/Money.text = "Money: " + str(money)

func notify(text: String, type: Notification.Type):
	var notification_node = notification_scene.instantiate()
	notification_node.text = text
	notification_node.set_type(type)
	$Notifications.add_child(notification_node)
	while $Notifications.get_child_count() > max_notifications:
		$Notifications.get_child(0).free()

func display_menu():
	set_process(false)
	$GameMenu.visible = true

func _on_maze_bead_finished(bead: Bead) -> void:
	lives -= 1
	if lives <= 0:
		lives = 0
		display_menu()
	update_lives_ui()


func _on_floor_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			GameManager.set_state(GameManager.State.IDLE)
			

# Called when a bead is destroyed.
func _on_maze_bead_killed(bead: Bead) -> void:
	money += bead.bounty
	update_money_ui()

# Called when player clicks a tower button.
# Begins tower placement if player has enough money
func _on_tower_button_pressed(tower: Tower) -> void:
	if money >= tower.cost:
		$PlacementGrid.set_tower_to_place(tower)
		GameManager.set_state(GameManager.State.PLACING)
	else:
		notify("Not enough money!", Notification.Type.CAUTION)

# Called when player finishes placing a tower.
func _on_placement_grid_tower_placed(tower: Tower) -> void:
	money -= tower.cost
	update_money_ui()


func _on_placement_grid_tower_selected(tower_controller: TowerController) -> void:
	if tower_controller == null:
		$SelectionView.visible = false
	else:
		$SelectionView.visible = true
	if tower_controller != selected_tower:
		if selected_tower != null:
			selected_tower.deselect()
		selected_tower = tower_controller
		$SelectionView/SelectionName.text = selected_tower.tower.name
		$SelectionView/TargetingOption.select(selected_tower.targeting_mode)


func _on_targeting_option_item_selected(index: int) -> void:
	selected_tower.targeting_mode = index as Constants.Targeting


func _on_upgrade_button_pressed() -> void:
	pass # Replace with function body.


func _on_sell_button_pressed() -> void:
	pass # Replace with function body.
