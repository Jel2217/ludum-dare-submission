extends Control

var glitch = preload("res://Scenes/Glitch.tscn")
onready var folder = get_node("MarginContainer/VBoxContainer/CanvasLayer/AnimatedSprite/Glitches")
		

func add_glitch():
	var instance = glitch.instance()
	folder.add_child(instance)


func _on_Timer_timeout():
	add_glitch()
