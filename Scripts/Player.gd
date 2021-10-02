extends KinematicBody2D


var speed = 150

var velocity = Vector2.ZERO
onready var sprite = $AnimatedSprite
onready var sword = $Pivot/laser_sword 
var sword_index 

func _ready():
	sword_index = $Pivot.get_index()

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
		sprite.flip_h = false 
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		sprite.flip_h = true
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if velocity == Vector2.ZERO:
		sprite.play("idle")
	else:
		sprite.play("moving")

	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	sword.look_at(get_global_mouse_position())
	sword.rotation_degrees -= 90
	if sword.rotation_degrees > 359:
		sword.rotation_degrees -= 360
	if sword.rotation_degrees < -359:
		sword.rotation_degrees += 360
	if rad2deg(sword.rotation) > 90 and rad2deg(sword.rotation) < 270:
		move_child($Pivot, 0)
	else:
		move_child($Pivot, sword_index)
	print(rad2deg(sword.rotation))
