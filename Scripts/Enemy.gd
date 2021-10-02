extends KinematicBody2D


var speed = 100
onready var nav =  get_node("/root/Level/Navigation2D")
onready var player =  get_node("/root/Level/Player")
var path := PoolVector2Array()

func _physics_process(delta):
	if Input.is_action_pressed("test"):
		path = nav.get_simple_path(player.position, position)
	# Calculate the movement distance for this frame
	var distance_to_walk = speed * delta
	# Move the player along the path until he has run out of movement or the path ends.
	while distance_to_walk > 0 and path.size() > 0:
		var distance_to_next_point = position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			# The player does not have enough movement left to get to the next point.
			position += position.direction_to(path[0]) * distance_to_walk
		else:
			# The player get to the next point
			position = path[0]
			path.remove(0)
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point
