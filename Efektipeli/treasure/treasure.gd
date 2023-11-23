extends Area2D




func _on_body_entered(body):
	
	if body.name == "Player":
		$Timer.start()
		Game.Treasure += 1
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0,25), 0.3)
		tween1.tween_property(self, "modulate:a", 0, 0.3)
		tween.tween_callback(queue_free)
		
		


func _on_timer_timeout():
	print("Working")
	get_tree().change_scene_to_file("res://end_scene.tscn")