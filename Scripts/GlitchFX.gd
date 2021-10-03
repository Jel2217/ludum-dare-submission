extends Control
	
var explosion = preload("res://Scenes/Effects/Explosion.tscn")
var enemy = preload("res://Scenes/Enemy1.tscn")

onready var player = get_tree().get_root().find_node("Player")

var numEnemies = 3

export var x = 10
export var y = 10

func invert(set):
	get_node("Invert").visible = set

func wirl(set):
	get_node("Wirl").visible = set

func normalise(set):
	get_node("Normalised").visible = set

func deepfried(set):
	get_node("Deep Fried").visible = set

func wave(set):
	get_node("Wave").visible = set
	
func explosions():
	var instance = explosion.instance()
	instance.position = player.position
	instance.start()
	add_child(instance)
	
func invis():
	player.hide()
	$InvisTimer.start()

func teleport():
	player.position = generate_random_pos()

func enemy():
	for i in numEnemies:
		var e = enemy.instance()
		e.position = generate_random_pos()
		player.get_parent().add_child(e)
	

func generate_random_pos():
	randomize()
	var x_off = rand_range(-x,x)
	var y_off = rand_range(-y,y)
	var x_pos = player.position.x + x_off 
	var y_pos = player.position.y + y_off 
	return Vector2(x_pos, y_pos)

func fat():
	player.speed = 50
	$FatTimer.start()

func _on_InvisTimer_timeout():
	player.show()


func _on_FatTimer_timeout():
	player.speed = 150
