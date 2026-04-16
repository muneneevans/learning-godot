extends Node

signal set_cam_rotation(_cam_rotation: float)

@onready var yaw_node = $CameraYaw
@onready var pitch_node = $CameraYaw/CameraPitch
@onready var camera = $CameraYaw/CameraPitch/SpringArm3D/Camera3D

var yaw: float = 0 ; 
var pitch: float = 0 ;

var yaw_sensitivity : float = 0.07;
var pitch_sensitivity : float = 0.07; 

var yaw_acceleration: float = 15 ; 
var pitch_acceleration: float = 15;

var pitch_max: float = 75;
var patch_min: float = -55

var tween: Tween

func _ready()-> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event) -> void:
	if event is InputEventMouseMotion:
		yaw += -event.relative.x * yaw_sensitivity
		pitch +=  -event.relative.y * pitch_sensitivity
	if event is InputEventJoypadMotion:
		if event.axis == JOY_AXIS_RIGHT_X:
			print("yaw")
			yaw += -event.axis_value *2
		if event.axis == JOY_AXIS_RIGHT_Y:
			print("pitch", event.axis_value)
			pitch += event.axis_value *2
		
func _handle_joystick_motion():
	var right_x = Input.get_joy_axis(0, JOY_AXIS_RIGHT_X)
	var right_y = Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)

	var deadzone = 0.15
	if abs(right_x) < deadzone:
		right_x = 0.0
	if abs(right_y) < deadzone:
		right_y = 0.0
	
	yaw += -right_x * yaw_sensitivity * 50
	pitch += -right_y * pitch_sensitivity * 50


func _physics_process(delta: float) -> void:
	_handle_joystick_motion()

	pitch = clamp(pitch, patch_min, pitch_max)
	
	yaw_node.rotation_degrees.y = lerp(yaw_node.rotation_degrees.y , yaw , yaw_acceleration * delta )
	pitch_node.rotation_degrees.x = lerp(pitch_node.rotation_degrees.x , pitch , pitch_acceleration * delta)

	set_cam_rotation.emit(yaw_node.rotation.y)
	
func _on_set_movement_state(_movement_state: MovementState):
	if tween:
		tween.kill()
		
	tween = create_tween()
	tween.tween_property(camera, 'fov', _movement_state.camera_fov , 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
