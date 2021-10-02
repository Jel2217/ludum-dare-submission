extends KinematicBody2D

var move_speed = 100
var speed = 100
onready var nav =  get_node("/root/Control/Level/Navigation2D")
onready var player =  get_node("/root/Control/Level/Player")
onready var line =  get_node("/root/Control/Level/Line")
var path
var points
var points_index = 0
var velocity = Vector2.ZERO
var epsilon = 1

enum states {IDLE, ATTACKING, MOVING}
var state = states.MOVING

func _physics_process(_delta):
	if Input.is_action_pressed("test"):
		pass
	
	match state:
		states.IDLE:
			pass
		states.ATTACKING:
			pass
		states.MOVING: 
			pathfind_to(player.position)



func pathfind_to(location):
	points_index = 0
	points = nav.get_simple_path(position, location, true)
	line.set_points(points)
	if !points: return
	if points_index>=points.size():
		return
	var target = points[points_index]
	if position.distance_to(target) < epsilon:
		points_index = points_index + 1
		if points_index>=points.size():
			return
		target = points[points_index]
	velocity = (target - position).normalized() * move_speed
	velocity = move_and_slide(velocity)
