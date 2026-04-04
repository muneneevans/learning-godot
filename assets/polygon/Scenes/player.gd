class_name Player extends CharacterBody3D
@onready var player: Player = $"."
@onready var input_component: InputComponent = $InputComponent
@onready var movement_component: MovementComponent = $MovementComponent


func _physics_process(delta: float) -> void:
	# READ CONTROLS
	input_component.update()

	# Movement
	movement_component.direction = input_component.move_direction
	movement_component.wants_to_jump = input_component.jump_pressed
	movement_component.tick(delta)
 
