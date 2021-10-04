extends Control

var level = 1
var experience = 0
var level_up_xp = 100
onready var player = get_parent().get_parent().get_node("Player")
onready var bar = $Experience
onready var text = $Level
var xp_path = "user://exp.save"
var lvl_path = "user://lvl.save"

func _ready():
	level = load_lvl()
	experience = load_xp()
	player.buff(level)
	text.text = String(level)
	level_up_xp = (3^level)+10
	bar.value = experience
	bar.max_value = level_up_xp
	
	
func on_enemy_killed():
	experience = experience + 1
	bar.value = experience
	save_xp(experience)
	if experience == level_up_xp:
		on_level_up()
	 

	
func on_level_up():
	level = level + 1
	level_up_xp = (3^level)+10
	experience = 0
	text.text = String(level)
	bar.max_value = level_up_xp
	bar.value = experience
	player.buff(level)
	save_xp(experience)
	save_lvl(level)
	
	

func save_lvl(lvl):
	var file = File.new()
	file.open(lvl_path, File.WRITE)
	file.store_var(lvl)
	file.close()
	
func load_lvl():
	var file = File.new()
	if file.file_exists(lvl_path):
		file.open(lvl_path, File.READ)
		var lvl = file.get_var()
		file.close()
		return lvl
	else:
		var lvl = 1
		return lvl
		
func save_xp(xp):
	var file = File.new()
	file.open(xp_path, File.WRITE)
	file.store_var(xp)
	file.close()
	
func load_xp():
	var file = File.new()
	if file.file_exists(xp_path):
		file.open(xp_path, File.READ)
		var expr = file.get_var()
		file.close()
		return expr
	else:
		var expr = 0
		return expr
