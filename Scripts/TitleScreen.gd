extends Control

onready var settings = $Settings
onready var main = $Main

var is_fullscreen = false

func _ready():
	for child in main.get_children():
		if child is Button: child.disabled = false
	for child in settings.get_children():
		if child is Button: child.disabled = true
		elif child is HSlider: child.editable = false
	settings.visible = false
	

func _input(event):
	if event.is_action("pause"):
		main.visible = true
		settings.visible = false
		for child in main.get_children():
			child.disabled = false
		for child in settings.get_children():
			child.disabled = true
		
# Main screen calls
func _on_Quit_pressed():
	get_tree().quit()

func _on_Settings_pressed():
	AudioStreamManager.play("res://Audio/GetAPowerUp.wav")
	main.visible = false
	for child in main.get_children(): # Make sure they cannot be clicked in background
		if child is Button: child.disabled = true
	settings.visible = true
	for child in settings.get_children():
		if child is Button: child.disabled = false
		elif child is HSlider: child.editable = true

func _on_Play_pressed():
#	get_tree().change_scene("res://Scenes/NormalLevel.tscn")
	pass

# Settings screen calls
func _on_Back_pressed():
	AudioStreamManager.play("res://Audio/GetAPowerUp.wav")
	main.visible = true
	for child in main.get_children(): # Make sure they cannot be clicked in background
		if child is Button: child.disabled = false
	settings.visible = false
	for child in settings.get_children():
		if child is Button: child.disabled = true
		elif child is HSlider: child.editable = false

func _on_Fullscreen_pressed():
	AudioStreamManager.play("res://Audio/GetAPowerUp.wav")
	if is_fullscreen:
		OS.window_fullscreen = false
		is_fullscreen = false
		$Settings/Fullscreen.text = "Fullscreen: OFF"
	else:
		OS.window_fullscreen = true
		is_fullscreen = true
		$Settings/Fullscreen.text = "Fullscreen: ON"

# TODO: add music and sfx buttons
#func _on_Music_pressed():
#	AudioStreamManager.play("res://Audio/GetAPowerUp.wav")
#	if $AudioStreamPlayer.playing:
#		$AudioStreamPlayer.stop()
#		$Settings/Music.text = "Music: OFF"
#		AudioStreamManager.mus_active = false
#
#	else:
#		$AudioStreamPlayer.play()
#		$Settings/Music.text = "Music: ON"
#		AudioStreamManager.mus_active = true
#
	
#func _on_SFX_pressed():
#	if AudioStreamManager.active == true:
#		AudioStreamManager.active = false
#		$Settings/SFX.text = "Sound Effects: OFF"
#	else:
#		AudioStreamManager.active = true
#		$Settings/SFX.text = "Sound Effects: ON"
#	AudioStreamManager.play("res://Audio/GetAPowerUp.wav")
