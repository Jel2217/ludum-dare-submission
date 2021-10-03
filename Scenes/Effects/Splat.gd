extends Particles2D


func start():
	$SFX.play()
	set_emitting(true)
	#$Timer.start()


func _on_Timer_timeout():
	get_parent().queue_free()
