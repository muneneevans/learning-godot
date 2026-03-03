extends CharacterBody3D


const SPEED = 3.5
const JUMP_VELOCITY = 4.5

@onready var visuals = $visuals
@onready var animation_player =  $visuals/UAL1_Standard/AnimationPlayer
@export var sens_horizontal := 0.5
@export var sens_vertical := 0.5

var heading = Vector3.ZERO


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		%camera_mount.rotation_degrees.y -= event.relative.x * 0.5
		%camera_mount.rotation_degrees.x -= event.relative.y * 0.5
		%camera_mount.rotation_degrees.x = clamp(%camera_mount.rotation_degrees.x , -30.0,10.0)

	elif event.is_action_pressed('ui_cancel'):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		pass

	## Get the input direction and handle the movement/deceleration.
	if Input.is_action_pressed("move_back"):
		velocity.z = SPEED
	elif Input.is_action_pressed("move_forward"):
		velocity.z = -SPEED
	else:
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if Input.is_action_pressed("move_forward") or Input.is_action_pressed("move_back") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		# rotate the player to the direction of the camera
		var camera_forward = -%camera_mount.global_transform.basis.z
		visuals.look_at(position + camera_forward, Vector3.UP)

		# Get input direction
		var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		var input_vec := Vector3(input_dir.x, 0, input_dir.y)

		# Rotate input vector by visuals' Y rotation
		var y_rot = visuals.global_transform.basis.get_euler().y
		var rotated_vec = input_vec.rotated(Vector3.UP, y_rot).normalized()

		velocity.x = rotated_vec.x * SPEED
		velocity.z = rotated_vec.z * SPEED

		handle_animations(rotated_vec)
		move_and_slide()


func handle_animations(direction):
	
	if direction:
		if animation_player.current_animation != "Walk":
			animation_player.play("Walk")
		

	else:
		if animation_player.current_animation != "Idle":
			animation_player.play("Idle")


	if Input.is_action_pressed("aim"):
		if animation_player.current_animation != "Pistol_Idle":
			animation_player.play("Pistol_Idle")
	if Input.is_action_just_released("aim"):
			# animation_player.stop()
			pass
	
	if Input.is_action_pressed("shoot"):
		if animation_player.current_animation != "Pistol_Shoot":
			# animation_player.animation_set_next("Pistol_Shoot", "Pistol_Idle")
			animation_player.play("Pistol_Shoot")
