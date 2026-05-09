extends Node3D

class_name NPCVehicleController


@export var vehicle_node: Vehicle


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func move(throttle, brake , handbrake , steering_input, reverse):
	vehicle_node.brake_input = brake
	vehicle_node.steering_input = steering_input
	vehicle_node.throttle_input = pow(throttle, 2.0)
	vehicle_node.handbrake_input = handbrake

	if reverse:
		vehicle_node.throttle_input = brake
		vehicle_node.brake_input = throttle
