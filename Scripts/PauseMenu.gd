extends CanvasLayer

onready var blur = $"../UI/Blur"
onready var cont = $VBoxContainer
var menu_open = false
var resume_pressed = false
var loading_time = 0.0

func _process(delta):
	loading_time += delta


func _input(event):
	if loading_time < 3: return # Can't pause while countdown
	if event.is_action_pressed("pause") or resume_pressed:
		if menu_open:
			get_tree().paused = false
			menu_open = false
			blur.material.set_shader_param("blur_amount", 0)
			cont.visible = false
		else:
			get_tree().paused = true
			menu_open = true
			blur.material.set_shader_param("blur_amount", 2)
			cont.visible = true
		resume_pressed = false
		


func _on_ResumeButton_pressed():
	resume_pressed = true


func _on_TitleButton_pressed():
	for p in get_tree().get_nodes_in_group("projectile"): # projectiles linger on screen otherwise
		p.queue_free()
	get_tree().quit()
