extends Control

var glitch = preload("res://Scenes/Glitch.tscn")
onready var folder = get_node("MarginContainer/VBoxContainer/CanvasLayer/AnimatedSprite/Glitches")

func get_input():
	if Input.is_action_just_pressed('ui_accept'):
		add_glitch()
		

func _physics_process(delta):
	get_input()

func add_glitch():
	var instance = glitch.instance()
	folder.add_child(instance)
