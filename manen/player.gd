extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var right_hand: Node3D = %right_hand

@onready var left_hand: Node3D = %left_hand

@onready var right_weapon=right_hand.get_child(0)
@onready var left_weapon=left_hand.get_child(0)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, %Camera3D.global_rotation.y)

	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		# Make the player face the movement direction
		var look_target = global_transform.origin + Vector3(direction.x, 0, direction.z)
		$all_da_shit.look_at(look_target, Vector3.UP)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if Input.is_action_pressed("up") and right_weapon.has_method("up_attack"):
				print("up_attack")
				right_weapon.up_attack()
			elif right_weapon.has_method("idle_attack"):
				print("attac")
				right_weapon.idle_attack()
