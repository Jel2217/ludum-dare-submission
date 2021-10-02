extends Particles2D

func start():
	$SFX.play()
	emitting = true
	$Timer.start()


func _on_Timer_timeout():
	queue_free()
