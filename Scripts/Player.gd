extends KinematicBody2D


var speed = 150

var velocity = Vector2.ZERO
onready var sprite = $AnimatedSprite
onready var sword = $Pivot/laser_sword 

var projectile = preload("res://Scenes/Projectile.tscn")

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

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	sword.look_at(get_global_mouse_position())
	sword.rotation_degrees -= 90
	if Input.is_action_just_pressed("click"):
		fire_projectile()


func fire_projectile():
	var proj = projectile.instance()
	add_child(proj)
	proj.global_transform = $Pivot/laser_sword/Muzzle.global_transform
	proj.rotation_degrees += 90
