extends Control

var level = 0
var experience = 0
var level_up_xp = 100
onready var player = get_parent()
onready var bar = $Experience
onready var text = $Level

func _ready():
	pass
	#load all values from file
	player.buff(level)
	
	
func on_enemy_killed():
	experience = experience + 1
	bar.value = experience
	#load everything back into file

	
func on_level_up():
	level = level + 1
	level_up_xp = (3^level)+10
	experience = 0
	text.text = level.to_string()
	bar.max_value = level_up_xp
	bar.value = experience
	player.buff(level)
	#load everything back into file
