extends KinematicBody2D


# Healthbar
var green_bar = preload("res://Images/UI/EnemyHealthBar/greenbar.png")
var red_bar = preload("res://Images/UI/EnemyHealthBar/redbar.png")
var yellow_bar = preload("res://Images/UI/EnemyHealthBar/yellowbar.png")
var splat = preload("res://Scenes/Effects/Splat.tscn")
onready var healthbar = $Healthbar

var max_health = 100
var health = 100
var dead = false

var move_speed = 7500
var speed = 100
onready var nav =  get_node("/root/Control/Level/Navigation2D")
onready var player =  get_node("/root/Control/Level/Player")
var path
var points
var points_index = 0
var velocity = Vector2.ZERO
var glob_loc
var epsilon = 1
var lunging = false
var retreating = false
var enemy_stopping_distance = 50
var is_attacking = false
enum states {IDLE, ATTACKING, MOVING, DEAD}
var state = states.MOVING

func _ready():
	healthbar.hide()
	health = max_health
	healthbar.max_value = max_health


func _physics_process(delta):
	if Input.is_action_pressed("test"):
		pass
	match state:
		states.IDLE:
			pass
		states.ATTACKING:
			if (player.position - position).length() > enemy_stopping_distance:
				state = states.MOVING
		states.MOVING: 
			if pathfind_to(player.position, delta): # If pathfinding has finished
				state = states.ATTACKING
		states.DEAD:
			set_collision_mask(0)
			set_collision_layer(0)
	if lunging:
		move_and_collide(velocity*delta*speed)
	if retreating:
		move_and_collide(-velocity*delta*speed)



func pathfind_to(location, delta):
	glob_loc = location
	points_index = 0
	points = nav.get_simple_path(position, location, true)
	if !points: return false
	if points_index>=points.size():
		return false
	var target = points[points_index]
	if position.distance_to(target) < epsilon:
		points_index = points_index + 1
		if points_index>=points.size():
			return false
		target = points[points_index]
	if !is_attacking:
		velocity = (target - position).normalized() * move_speed * delta
		velocity = move_and_slide(velocity)
	if (location - position).length() < enemy_stopping_distance:
		$AttackTimer.start()
		return true

func update_healthbar(value):
	healthbar.texture_progress = green_bar
	if value < healthbar.max_value * 0.7:
		healthbar.texture_progress = yellow_bar
	if value < healthbar.max_value * 0.35:
		healthbar.texture_progress = red_bar
	if value < healthbar.max_value:
		healthbar.show()
	healthbar.value = value

func update_health(value):
	if state == states.DEAD: return
	update_healthbar(value)
	health = value
	if health <= 0:
		state = states.DEAD
		var instance = splat.instance()
		$Sprite.hide()
		$Healthbar.hide()
		instance.start()
		add_child(instance)
		$Timer.start()
		


func _on_Timer_timeout():
	queue_free()


func _on_AttackTimer_timeout():
	if (glob_loc - position).length() < enemy_stopping_distance:
		is_attacking = true
		velocity = (glob_loc-position).normalized()
		lunging = true
		retreating = false
		$WaitTimer.start()
	else:
		is_attacking = false
		retreating = false
		lunging = false


func _on_WaitTimer_timeout():
	velocity = (glob_loc-position).normalized()
	retreating = true
	lunging = false
	$StopTimer.start()
	$AttackTimer.start()


func _on_StopTimer_timeout():
	velocity = (glob_loc-position).normalized()
	retreating = false
