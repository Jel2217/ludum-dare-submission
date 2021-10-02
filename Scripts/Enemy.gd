extends KinematicBody2D

var move_speed = 100
var speed = 100
onready var nav =  get_node("/root/Level/Navigation2D")
onready var player =  get_node("/root/Level/Player")
var path
var points
var points_index = 0
var velocity = Vector2.ZERO


func _physics_process(delta):
	print(points_index)
	if Input.is_action_pressed("test"):
		print("y")
		points = nav.get_simple_path(player.position, position)
	if !points: return
	var target = points[points_index]
	if position.distance_to(target) < 1:
		target = points[points_index + 1]
	velocity = (target - position).normalized() * move_speed
	velocity = move_and_slide(velocity)
