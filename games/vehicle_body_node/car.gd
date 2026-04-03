extends VehicleBody3D

var throttle: float = 0
var steering_input: float =0

@export_group("Speed")
@export var max_speed: float = 50
@export var acceleration: float = 120
var vehicle_linear_velocity:float = 0

@export_group("Steering & Brake")
@export var steering_speed: float = 1.5
@export var max_steering_angle: float= 0.65
@export var handbrake_force:float  =5
var handbrake: bool = false

@export_group("wheel")
@export var front_left_wheel: VehicleWheel3D
@export var front_right_wheel: VehicleWheel3D
@export var rear_left_wheel: VehicleWheel3D
@export var rear_right_wheel: VehicleWheel3D


@export_group("Suspension Settings")
@export var wheel_friction: float = 10.5
@export var suspension_stiffness_value: float = 180


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for wheel in [front_right_wheel, front_left_wheel, rear_left_wheel , rear_right_wheel]:
		wheel.wheel_friction_slip = wheel_friction
		wheel.suspension_stiffness = suspension_stiffness_value


func _physics_process(delta: float) -> void:
	_handle_vehicle_control(delta)
	_handle_engine_velocity()


func _handle_vehicle_control(delta) -> void:
	throttle = Input.get_action_strength("accelerate") - Input.get_action_strength("decelerate")
	steering_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	handbrake = Input.is_action_pressed("handbrake")

	steering = move_toward(steering , -steering_input * max_steering_angle , delta * steering_speed)

func _handle_engine_velocity() -> void:
	vehicle_linear_velocity = linear_velocity.length()
	var speed_factor = 1 - min(vehicle_linear_velocity/max_speed, 1)

	engine_force = throttle * acceleration * speed_factor
