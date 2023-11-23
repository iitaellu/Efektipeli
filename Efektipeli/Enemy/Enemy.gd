#https://www.youtube.com/watch?v=S8lMTwSRoRg
extends CharacterBody2D

var DEATH = preload("res://effects/enemy_death.tscn")

var SPEED = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false

func _physics_process(delta):
	#Gravity for Frog
	velocity.y =+ gravity * delta
	if chase == true:
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		##if direction.x > 0:
			##get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction.x * SPEED
	else:
		velocity.x = 0
	
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true
		$Effects/enemy_angry.emitting = true
		$Effects/Enemy_peace.emitting = false


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false
		$Effects/enemy_angry.emitting = false
		$Effects/Enemy_peace.emitting = true


func _on_player_death_body_entered(body):
	if body.name == "Player":
		body.health =- 1
		death()
		#death()


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		$Timer.start()
		$Effects/Enemy_death.emitting = true
		$Effects/enemy_angry.emitting = false
		$AnimatedSprite2D.visible = false
		$PlayerDetection.visible = false
		
		
func death():
	chase= false
	self.queue_free()
	get_tree().change_scene_to_file("res://main.tscn")


func _on_timer_timeout():
	self.queue_free()
