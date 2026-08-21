extends Effect
class_name SpeedEffect

@export var speed_modification: float

func handle_initial_effect(bead_controller: BeadController):
	pass

func handle_ongoing_effect(bead_controller: BeadController):
	bead_controller.speed_modifier = speed_modification

func handle_repetition_effect(bead_controller: BeadController):
	pass

func handle_free(bead_controller: BeadController):
	pass
