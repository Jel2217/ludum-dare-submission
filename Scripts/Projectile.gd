extends Area2D

var speed = 700
onready var player = self.get_parent()

func _physics_process(delta):
	speed = player.bspeed
	position += transform.x * speed * delta


func _on_Projectile_body_entered(body):
	if body.is_in_group("player"): return
	if body.is_in_group("enemy"):
		if body.health - player.damage <= 5:
			body.update_health(0)
			player.enemy_hit()
		else:
			body.update_health(body.health - player.damage)
	queue_free()
