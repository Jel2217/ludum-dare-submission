extends KinematicBody2D

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

enum states {IDLE, ATTACKING, MOVING}
var state = states.MOVING

func _physics_process(_delta):
	if Input.is_action_pressed("test"):
		pass
	
	match state:
		states.IDLE:
			pass
		states.ATTACKING:
			if (player.position - position).length() > enemy_stopping_distance:
				state = states.MOVING
		states.MOVING: 
			if pathfind_to(player.position): # If pathfinding has finished
				state = states.ATTACKING



func pathfind_to(location):
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
	velocity = (target - position).normalized() * move_speed
	velocity = move_and_slide(velocity)
	print((location - position).length())
	if (location - position).length() < enemy_stopping_distance:
		return true
	
