extends KinematicBody2D

enum states {IDLE, MOVING, DEAD}
var state = states.IDLE

var speed = 150


var can_fire = true
var fire_delay = 0.25

var velocity = Vector2.ZERO
onready var sprite = $AnimatedSprite
onready var sword = $Pivot/laser_sword 

var projectile = preload("res://Scenes/Projectile.tscn")


var max_health = 6
var health = 6
signal health(value)

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
		state = states.IDLE
	else:
		state = states.MOVING

	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	get_input()
	if Input.is_action_just_pressed("test"):
		update_health(health - 1)
	velocity = move_and_slide(velocity)
	sword.look_at(get_global_mouse_position())
	sword.rotation_degrees -= 90
	if Input.is_action_pressed("click") and can_fire:
		fire_projectile()
	
	
	match state:
		states.IDLE:
			sprite.play("idle")
		states.MOVING:
			sprite.play("moving")
		states.DEAD:
			self.hide()


func fire_projectile():
	can_fire = false
	var proj = projectile.instance()
	add_child(proj)
	proj.global_transform = $Pivot/laser_sword/Muzzle.global_transform
	proj.rotation_degrees += 90
	yield(get_tree().create_timer(fire_delay), "timeout")
	can_fire = true

func update_health(value):
	if state == states.DEAD: return
	if value <= 0: state = states.DEAD
	health = value
	emit_signal("health", value)
	
