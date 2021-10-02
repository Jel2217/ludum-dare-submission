extends MarginContainer

var num_grids = 1
var current_grid = 1
var grid_width = 546

onready var gridbox = $VBoxContainer/HBoxContainer/ClipControl/GridBox
onready var tween = $Tween

func _ready():
	# Number all the level boxes and unlock them
	# Replace with your game's level/unlocks/etc.
	# You can also connect the "level_selected" signals
	num_grids = gridbox.get_child_count()
	for space in gridbox.get_children():
		for grid in space.get_children():
			for box in grid.get_children():
				var num = box.get_position_in_parent() + 1 + 18 * grid.get_position_in_parent()
				box.level_num = num
				box.locked = num > 1

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
	if level == 1:
		get_tree().change_scene("res://Scenes/Levels/Level-1.tscn")
