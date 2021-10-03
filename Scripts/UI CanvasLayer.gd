extends CanvasLayer

var full_heart = preload("res://Images/UI/Hearts/heart1.png")
var half_heart = preload("res://Images/UI/Hearts/heart2.png")
var empty_heart = preload("res://Images/UI/Hearts/heart3.png")
onready var heart_hbox = $"Heart Hbox"

func update_healthbar(value):
	for i in heart_hbox.get_child_count():
		if value > i * 2 + 1:
			heart_hbox.get_child(i).texture = full_heart
		elif value > i * 2:
			heart_hbox.get_child(i).texture = half_heart
		else:
			heart_hbox.get_child(i).texture = empty_heart
		print(i)


func _on_Player_health(value):
	update_healthbar(value)

func player_won():
	print("player won")

func player_lost():
	print("player lost")
