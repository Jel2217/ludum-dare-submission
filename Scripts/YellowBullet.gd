extends Area2D

var speed = 100

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_YellowBullet_body_entered(body):
	if body.is_in_group("player"):
		body.update_health(body.health - 1)
	queue_free()
