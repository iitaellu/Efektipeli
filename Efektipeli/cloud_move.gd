extends ParallaxLayer

var cloud_speed = -15


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	motion_offset.x += cloud_speed * delta
	#transform.position.y=0


