extends CharacterBody2D

var health = 1
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		$Effects/running.emitting = false

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$Effects/running.emitting = true
		if direction == -1:
			$Effects/running.process_material.gravity = Vector3(100,-10,0)
		if direction == 1:
			$Effects/running.process_material.gravity = Vector3(-100,-10,0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$Effects/running.emitting = false

	move_and_slide()
	
	if health <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://start_scene.tscn")

func _on_dead_byfalling_body_entered(body):
	if body.name == "Player":
		self.queue_free()
		get_tree().change_scene_to_file("res://start_scene.tscn")
	
