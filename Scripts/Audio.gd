extends Node
onready var Tmusic = get_parent().get_node("Audio").get_node("TitleMusic")
onready var GameMusic = get_parent().get_node("Audio").get_node("GameMusic")
var ready = false

func _ready():
	ready = true

func _process(_delta):
	if ready:
		if !((get_tree().current_scene.name == "TitleScreen") or (get_tree().current_scene.name == "LevelMenu")):
			if(!GameMusic.playing):
				Tmusic.stop()
				GameMusic.playing = true
		elif !(get_tree().current_scene.name == "Backstory"):
			if(!Tmusic.playing):
				Tmusic.playing = true
				GameMusic.stop()
		else:
			print("tt")
			Tmusic.stop()
			GameMusic.stop()
				
		
	
