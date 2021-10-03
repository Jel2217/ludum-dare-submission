extends KinematicBody2D


# Healthbar
var green_bar = preload("res://Images/UI/EnemyHealthBar/greenbar.png")
var red_bar = preload("res://Images/UI/EnemyHealthBar/redbar.png")
var yellow_bar = preload("res://Images/UI/EnemyHealthBar/yellowbar.png")
var redbullet = preload("res://Scenes/RedBullet.tscn")
var splat = preload("res://Scenes/Effects/YellowSplat.tscn")
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
var enemy_stopping_distance = 75

var is_attacking = false
enum states {IDLE, ATTACKING, MOVING, DEAD}
var state = states.MOVING

var activated_by_glitch = false

func _ready():
	healthbar.hide()
	health = max_health
	healthbar.max_value = max_health


func enable_activated_by_glitch():
	activated_by_glitch = true


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
	$Pivot.look_at(player.global_position)
	if !(player.global_position.angle_to_point(self.global_position)>-PI/4 && player.position.angle_to_point(self.position)<(PI)/4):
		$Sprite.flip_h=true
		$Pivot/Barrel.flip_h = true
	else:
		$Sprite.flip_h=false
		$Pivot/Barrel.flip_h = true


func pathfind_to(location, delta):
	if !player.is_visible():
		velocity = Vector2.ZERO
		state = states.IDLE
		return true
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
	if (player.position - position).length() < enemy_stopping_distance:
		var bullet = redbullet.instance()
		add_child(bullet)
		bullet.global_transform = $Pivot/Barrel/Muzzle.global_transform
		bullet.apply_scale(Vector2(4,4))
		$AttackTimer.start()
