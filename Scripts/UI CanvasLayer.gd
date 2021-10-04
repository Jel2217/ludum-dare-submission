extends CanvasLayer

var full_heart = preload("res://Images/UI/Hearts/heart1.png")
var half_heart = preload("res://Images/UI/Hearts/heart2.png")
var empty_heart = preload("res://Images/UI/Hearts/heart3.png")
var level_file = "user://level.save"
onready var heart_hbox = $"Heart Hbox"

var pause_menu_open = false

func update_healthbar(value):
	for i in heart_hbox.get_child_count():
		if value > i * 2 + 1:
			heart_hbox.get_child(i).texture = full_heart
		elif value > i * 2:
			heart_hbox.get_child(i).texture = half_heart
		else:
			heart_hbox.get_child(i).texture = empty_heart


func _on_Player_health(value):
	update_healthbar(value)

func player_won():
	$WinAux.play()
	if load_score() == get_parent().level:
		save_level(get_parent().level+1)
	$WinTimer.start()

func player_lost():
	$LoseTimer.start()
	
func save_level(level):
	var file = File.new()
	file.open(level_file, File.WRITE)
	file.store_var(level)
	file.close()
	
func load_score():
	var file = File.new()
	if file.file_exists(level_file):
		file.open(level_file, File.READ)
		var level = file.get_var()
		file.close()
		return level
	else:
		var level = 1
		return level

func _process(_delta):
		if Input.is_action_just_pressed("pause"):
			if pause_menu_open:
				$XpBar.show()
				$ColorRect.hide()
				$VBoxContainer.hide()
				$VBoxContainer/ResumeButton.disabled = true
				$VBoxContainer/ReturnButton.disabled = true
				get_tree().paused = false
				pause_menu_open = false
			else:
				$XpBar.hide()
				$ColorRect.show()
				$VBoxContainer.show()
				$VBoxContainer/ResumeButton.disabled = false
				$VBoxContainer/ReturnButton.disabled = false
				get_tree().paused = true
				pause_menu_open = true


func _on_LoseTimer_timeout():
	get_tree().change_scene("res://Scenes/Lose.tscn")


func _on_WinTimer_timeout():
	get_tree().change_scene("res://Scenes/Win.tscn")


func _on_ResumeButton_pressed():
	$XpBar.show()
	$ColorRect.hide()
	$VBoxContainer.hide()
	$VBoxContainer/ResumeButton.disabled = true
	$VBoxContainer/ReturnButton.disabled = true
	get_tree().paused = false
	pause_menu_open = false


func _on_ReturnButton_pressed():
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")
