extends KinematicBody2D

enum states {IDLE, MOVING}
var state = states.IDLE

var speed = 150
var dead = false

var can_fire = true
var fire_delay = 0.25

var velocity = Vector2.ZERO
onready var sprite = $AnimatedSprite
onready var sword = $Pivot/laser_sword 
onready var xp = get_parent().get_node("UI CanvasLayer/XpBar")

var projectile = preload("res://Scenes/Projectile.tscn")
var damage = 20
var bspeed = 700

var max_health = 20
var health = 20
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
	if dead: return
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


func fire_projectile():
	can_fire = false
	var proj = projectile.instance()
	add_child(proj)
	proj.global_transform = $Pivot/laser_sword/Muzzle.global_transform
	proj.rotation_degrees += 90
	yield(get_tree().create_timer(fire_delay), "timeout")
	can_fire = true

func update_health(value):
	health = value
	if health == 0:
		$"../UI CanvasLayer".player_lost()
		hide()
		dead = true
	emit_signal("health", value)
	
func buff(level):
	damage = 20 + (2*level)
	speed = 125 + (5*level)
	bspeed = 700 + (25*level)
	
func enemy_hit():
	xp.on_enemy_killed()
	
