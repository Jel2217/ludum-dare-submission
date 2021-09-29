extends AudioStreamPlayer


func _ready():
	if AudioStreamManager.mus_active:
		play()
