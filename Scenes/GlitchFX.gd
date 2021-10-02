tool

extends Control



func _ready():
	pass # Replace with function body.
	
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

func old(set):
	get_node("Ye Olde").visible = set
