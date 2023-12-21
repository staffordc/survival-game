extends CharacterBody3D

var camera: Camera3D
var head: Node3D

var move_speed : float = 5.0
var jump_force : float = 5.0
var gravity : float = 9.0
var look_sens : float = .5
var min_x_rot : float = -85
var max_x_rot : float = 85

var mouse_dir : Vector2


#"Head" is used so we don't have the camera freak out with the model
#this was not adequtely explained in the tutorial, and was a priori

#camera is being removed from head (dunno why) and placed onto "Main"
#call deferred so it isn't immediately flipping when that's an empty node .3s
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	camera = get_node("Camera3D")
	head = get_node("Head")
	remove_child(camera)
	get_node("/root/Main").add_child.call_deferred(camera)
	
func _input(event):
	# if mouse move:
	if event is InputEventMouseMotion:
		#vertical clamps
		camera.rotation_degrees.x += event.relative.y * -look_sens
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, min_x_rot, max_x_rot)
		#horizontal control
		camera.rotation_degrees.y += event.relative.x * -look_sens
	
func _process(delta): 
	camera.position = head.global_position
	
func _physics_process(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var dir = camera.basis.z * input.y + camera.basis.x * input.x
	dir.y = 0
	dir = dir.normalized()
	
	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed
	
	move_and_slide()
