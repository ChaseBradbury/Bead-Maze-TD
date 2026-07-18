extends Node

enum State {
	IDLE, PLACING, DRAGGING, SELECTED
}

var score = 100
var state: State

signal state_changed(new_state: State)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = State.IDLE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func lose_life():
	score -= 1

func is_state(check_state: State):
	return state == check_state

func set_state(new_state: State):
	state = new_state
	state_changed.emit(state)
