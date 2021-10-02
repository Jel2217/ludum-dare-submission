extends Control
	
var explosion = preload("res://Scenes/Effects/Explosion.tscn")
var player = get_tree().get_root().get_node("Player")
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

func generate_random_pos():
	var x_off = rand_range(-x,x)
	var y_off = rand_range(-y,y)
	var x_pos = player.position.x + x_off 
	var y_pos = player.position.y + y_off 
	return Vector2(x_pos, y_pos)

func _on_InvisTimer_timeout():
	player.show()
