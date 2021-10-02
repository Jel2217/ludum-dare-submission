extends Area2D

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_Projectile_body_entered(body):
	if body.is_in_group("player"): return
	if body.is_in_group("enemy"):
		body.health -= 25
		body.update_healthbar(body.health)
	queue_free()
