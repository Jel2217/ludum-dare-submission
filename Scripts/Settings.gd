extends VBoxContainer

onready var settings = self

var is_fullscreen = false
var fs_file = "user://fullscreen.save"


func _ready():
	is_fullscreen = !load_fs()
	toggle_fullscreen()
	for child in settings.get_children():
		if child is Button: child.disabled = false
		elif child is HSlider: child.editable = true
	settings.visible = false
	
# Settings screen calls
func _on_Back_pressed():
	AudioStreamManager.play("res://Audio/Select.wav")
	settings.visible = false
	get_parent().get_node("VBoxContainer").show()
	for child in get_children():
		if child is Button: child.disabled = true
		elif child is HSlider: child.editable = false

func _on_Fullscreen_pressed():
	AudioStreamManager.play("res://Audio/Select.wav")
	save_fs(!is_fullscreen)
	toggle_fullscreen()
	
func toggle_fullscreen():
	if is_fullscreen:
		OS.window_fullscreen = false
		is_fullscreen = false
		$Fullscreen.text = "Fullscreen: OFF"
	else:
		OS.window_fullscreen = true
		is_fullscreen = true
		$Fullscreen.text = "Fullscreen: ON"


func save_fs(full):
	var file = File.new()
	file.open(fs_file, File.WRITE)
	file.store_var(full)
	file.close()
	
func load_fs():
	var file = File.new()
	if file.file_exists(fs_file):
		file.open(fs_file, File.READ)
		var fs = file.get_var()
		file.close()
		return fs
	else:
		var fs = false
		return fs

	


func _on_audiotimer_timeout():
	get_tree().quit()
