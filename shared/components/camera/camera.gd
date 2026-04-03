extends Node3D

@export_group("Clamping")
@export var max_clamp: float = 10
@export var min_clamp: float = -30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		
		%camera_mount.rotation_degrees.y -= event.relative.x * 0.5
		%camera_mount.rotation_degrees.x -= event.relative.y * 0.5
		%camera_mount.rotation_degrees.x = clamp(%camera_mount.rotation_degrees.x , min_clamp, max_clamp) 

	elif event is InputEventJoypadMotion:
		var joy_input = Vector2(event.axis_value if event.axis == JOY_AXIS_RIGHT_X else 0,
								event.axis_value if event.axis == JOY_AXIS_RIGHT_Y else 0)
		%camera_mount.rotation_degrees.y -= joy_input.x * 2
		%camera_mount.rotation_degrees.x -= joy_input.y * 2
		%camera_mount.rotation_degrees.x = clamp(%camera_mount.rotation_degrees.x, min_clamp, max_clamp)


	elif event.is_action_pressed('ui_cancel'):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
