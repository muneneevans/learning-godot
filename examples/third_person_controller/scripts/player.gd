extends CharacterBody3D

signal set_movement_state(_movement_State: MovementState)
signal set_movement_direction(_direction: Vector3)
@onready var input_controller: InputController = $InputController

@export var movement_states: Dictionary

func _ready() -> void:
	set_movement_state.emit(movement_states['stand'])

func _physics_process(delta: float) -> void:
	input_controller.update()
	set_movement_state.emit(movement_states[input_controller.get_movement_state()])
	if input_controller.is_movement_ongoing():
		set_movement_direction.emit(input_controller.movement_direction)


	
