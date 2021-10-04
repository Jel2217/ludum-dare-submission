extends MarginContainer

var num_grids = 1
var current_grid = 1
var grid_width = 510
export var num_levels_unlocked = 1

var level_file = "user://level.save"

onready var gridbox = $VBoxContainer/HBoxContainer/ClipControl/GridBox
onready var tween = $Tween

func _ready():
	# Number all the level boxes and unlock them
	# Replace with your game's level/unlocks/etc.
	# You can also connect the "level_selected" signals
	num_levels_unlocked = load_score()
	num_grids = gridbox.get_child_count()
	for space in gridbox.get_children():
		for grid in space.get_children():
			for box in grid.get_children():
				var num = box.get_position_in_parent() + 1 + 15 * grid.get_position_in_parent()
				box.level_num = num
				box.locked = num > num_levels_unlocked

func _on_BackButton_pressed():
	if current_grid > 1:
		current_grid -= 1
#		gridbox.rect_position.x += grid_width
		tween.interpolate_property(gridbox, "rect_position:x",
				null, gridbox.rect_position.x + grid_width,
				0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
		tween.start()

func _on_NextButton_pressed():
	if current_grid < num_grids:
		current_grid += 1
#		gridbox.rect_position.x -= grid_width
		tween.interpolate_property(gridbox, "rect_position:x",
				null, gridbox.rect_position.x - grid_width,
				0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
		tween.start()
	


func _on_LevelGrid_level_selected(level):
	select_level(level)


func _on_LevelGrid2_level_selected(level):
	select_level(level)
	
func select_level(level):
	if level <= 15:
		AudioStreamManager.play("res://Audio/Select.wav")
		var l = String(level)
		get_tree().change_scene("res://Scenes/Levels/Level-"+l+".tscn")



func save_level(level):
	var file = File.new()
	file.open(level_file, File.WRITE)
	file.store_var(level)
	file.close()
	
func load_score():
	var file = File.new()
	if file.file_exists(level_file):
		file.open(level_file, File.READ)
		var level = file.get_var()
		file.close()
		return level
	else:
		var level = 1
		return level
