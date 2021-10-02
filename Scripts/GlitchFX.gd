tool

extends Control

#onready var camera = get_parent().get_node("Player/Camera2D")

func _ready():
	pass
	
func invert(set):
	get_node("Invert").visible = set

func wirl(set):
	get_node("Wirl").visible = set

func normalise(set):
	get_node("Normalised").visible = set

func deepfried(set):
	get_node("Deep Fried").visible = set

func wave(set):
	get_node("Wave").visible = set


#func _process(_delta):
	#print(camera.name)
	#self.position = camera.position
