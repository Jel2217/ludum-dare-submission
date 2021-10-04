extends PanelContainer

signal level_selected

var locked = true setget set_locked
var level_num = 1 setget set_level

onready var label = $Cont/Label
onready var lock = $Cont/MarginContainer

func set_locked(value):
	locked = value
	lock.visible = value
	label.visible = not value

func set_level(value):
	level_num = value
	label.text = str(level_num)

func _on_LevelBox_gui_input(event):
	if locked:
		return
	if event is InputEventMouseButton and event.pressed:
		emit_signal("level_selected", level_num)


func _on_LevelBox_mouse_entered():
	pass # Replace with function body.


func _on_LevelBox_mouse_exited():
	pass # Replace with function body.


func _on_Cont_gui_input(event):
	if locked:
		return
	if event is InputEventMouseButton and event.pressed:
		emit_signal("level_selected", level_num)
