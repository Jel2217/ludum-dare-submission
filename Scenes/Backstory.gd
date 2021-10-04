extends Control

var story_path = "user://story.save"

export var audio_bus_name := "Music"
onready var _bus := AudioServer.get_bus_index(audio_bus_name)

func _ready():
	if load_story():
		get_tree().change_scene("res://Scenes/LevelMenu.tscn")
	else:
		AudioServer.set_bus_volume_db(_bus, linear2db(0))
		$AnimationPlayer/ColorRect.modulate.a=0
		save_story(true)
		$AnimationPlayer.play("Text")
		$Timer.start()

	
func save_story(s):
	var file = File.new()
	file.open(story_path, File.WRITE)
	file.store_var(s)
	file.close()
	
func load_story():
	var file = File.new()
	if file.file_exists(story_path):
		file.open(story_path, File.READ)
		var s = file.get_var()
		file.close()
		return s
	else:
		return false


func _on_Timer_timeout():
	AudioServer.set_bus_volume_db(_bus, -8.0)
	get_tree().change_scene("res://Scenes/LevelMenu.tscn")
