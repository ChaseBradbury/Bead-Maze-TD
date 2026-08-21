extends Resource
class_name Effect

@export var timer: float
@export var num_repetitions: int

var time_elapsed: float = 0.0
var current_reps: int = 0

func initialize_effect(bead_controller: BeadController):
	handle_initial_effect(bead_controller)

func process_effect(bead_controller: BeadController, delta: float):
	time_elapsed += delta
	handle_ongoing_effect(bead_controller)
	if time_elapsed > timer:
		time_elapsed = 0.0
		print("here")
		handle_repetition_effect(bead_controller)
		current_reps += 1
		if current_reps > num_repetitions:
			bead_controller.effects.erase(self)
			free_effect(bead_controller)

func free_effect(bead_controller: BeadController):
	handle_free(bead_controller)

func handle_initial_effect(bead_controller: BeadController):
	pass

func handle_ongoing_effect(bead_controller: BeadController):
	pass

func handle_repetition_effect(bead_controller: BeadController):
	pass

func handle_free(bead_controller: BeadController):
	pass
