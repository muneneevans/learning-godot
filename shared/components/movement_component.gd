class_name MovementComponent extends Node

@export var body : CharacterBody3D
@export var model : Node3D
@export var speed : float = 5.0
@export var jump_velocity : float = 4.0
@export var gravity_multiplier : float = 2.0


var direction : Vector2 = Vector2.ZERO
var wants_to_jump : bool = false

func tick(delta: float) -> void:
	if body == null:
		return
	
	# top down movement
	body.velocity.x = direction.x * speed
	body.velocity.z = direction.y * speed

	#Gravity
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta * gravity_multiplier
	
	# jump
	if wants_to_jump and body.is_on_floor():
		body.velocity.y = jump_velocity
		wants_to_jump = false
	
	body.move_and_slide()


	# Face movement direction
	if model && direction.length_squared() > 0.01:
		var look_direction = Vector3(-direction.x, 0 , -direction.y).normalized()
		model.look_at( model.global_position + look_direction, Vector3.UP)
