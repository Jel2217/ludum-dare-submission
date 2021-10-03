extends Control
	
var explosion = preload("res://Scenes/Effects/Explosion.tscn")
var enemy = preload("res://Scenes/Enemies/BlueSlime.tscn")

onready var player = get_parent().get_parent().find_node("Player")

var numEnemies = 3

export var x = 100
export var y = 100


func invert():
	get_node("Invert").visible = true
	$ScreenTimer.start()

func whirl():
	get_node("Whirl").visible = true
	$ScreenTimer.start()
	
func normalise():
	get_node("Normalised").visible = true
	$ScreenTimer.start()
	
func deepfried():
	get_node("Deep Fried").visible = true
	$ScreenTimer.start()
	
func wave():
	get_node("Wave").visible = true
	$ScreenTimer.start()
	
func explosions():
	var instance = explosion.instance()
	add_child(instance)
	instance.global_position = player.global_position
	instance.start()

	
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
	var x_off = rand_range(10,x)
	var y_off = rand_range(10,y)
	var negitive = round(rand_range(0,3))
	if negitive == 1||3:
		x_off = x_off*-1
	if negitive == 1||3:
		y_off = y_off*-1
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

func heal():
	player.update_health(player.health + 2)

func poisin():
	player.update_health(player.health - 2)


func _on_ScreenTimer_timeout():
	get_node("Invert").visible = false
	get_node("Whirl").visible = false
	get_node("Normalised").visible = false
	get_node("Deep Fried").visible = false
	get_node("Wave").visible = false
