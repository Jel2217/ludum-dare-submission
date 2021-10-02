extends Particles2D

func start():
	$SFX.play()
	emitting = true
	$Timer.start()


func _on_Timer_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.has_method("update_health"):
		var new_health = body.health-20
		body.update_health(new_health)
