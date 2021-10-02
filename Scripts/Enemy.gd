extends KinematicBody2D


# Healthbar
var green_bar = preload("res://Images/UI/EnemyHealthBar/greenbar.png")
var red_bar = preload("res://Images/UI/EnemyHealthBar/redbar.png")
var yellow_bar = preload("res://Images/UI/EnemyHealthBar/yellowbar.png")
onready var healthbar = $Healthbar

var max_health = 100
var health = 100


var move_speed = 100
var speed = 100
onready var nav =  get_node("/root/Control/Level/Navigation2D")
onready var player =  get_node("/root/Control/Level/Player")
var path
var points
var points_index = 0
var velocity = Vector2.ZERO
var epsilon = 1

var enemy_stopping_distance = 20

enum states {IDLE, ATTACKING, MOVING, DEAD}
var state = states.MOVING

func _ready():
	healthbar.hide()
	health = max_health
	healthbar.max_value = max_health


func _physics_process(delta):
	if Input.is_action_pressed("test"):
		pass
	print(health)
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
			queue_free()



func pathfind_to(location, delta):
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
	velocity = (target - position).normalized() * move_speed * delta
	velocity = move_and_slide(velocity)
	print((location - position).length())
	if (location - position).length() < enemy_stopping_distance:
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
	update_healthbar(value)
	health = value
	if health <= 0:
		state = states.DEAD
