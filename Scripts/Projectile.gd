extends Area2D

var speed = 700
onready var player = self.get_parent()

func _physics_process(delta):
	speed = player.bspeed
	position += transform.x * speed * delta


func _on_Projectile_body_entered(body):
	if body.is_in_group("player"): return
	if body.is_in_group("enemy"):
		if body.health-25 <= 0:
			body.update_health(body.health - player.damage)
			player.enemy_hit()
		else:
			body.update_health(body.health - 25)
	queue_free()
