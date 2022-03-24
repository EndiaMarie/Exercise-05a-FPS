extends KinematicBody

onready var Camera = $Pivot/Camera

var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.002
var mouse_range = 1.2

var velocity = Vector3()

func get_input():
	var input_dir = Vector3.ZERO
	if Input.is_action_pressed("foward"):
		input_dir += -Camera.global_transform.basis.z
	if Input.is_action_pressed("backward"):
		input_dir += Camera.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -Camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += Camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir
	
func _unhandeled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)
	
func _physics_process(delta):
		var desired_velocity = get_input() * max_speed
		velocity.y += gravity * delta
		
		velocity.x = desired_velocity.x
		velocity.y = desired_velocity.z
		velocity = move_and_slide(velocity, Vector3.UP, true)
		
		
