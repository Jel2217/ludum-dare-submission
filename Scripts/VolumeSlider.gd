extends HSlider


export var audio_bus_name := "Master"
var volume_file = "user://vol.save"

onready var _bus := AudioServer.get_bus_index(audio_bus_name)


func _ready() -> void:
	value = load_vol()
	AudioServer.set_bus_volume_db(_bus, linear2db(value))
	


func _on_Volume_value_changed(value: float):
	save_vol(value)
	AudioServer.set_bus_volume_db(_bus, linear2db(value))
#	$"../../AudioStreamPlayer".volume_db = linear2db(value)


func _on_Volume_mouse_exited():
	release_focus()

func save_vol(volume):
	var file = File.new()
	file.open(volume_file, File.WRITE)
	file.store_var(volume)
	file.close()
	
func load_vol():
	var file = File.new()
	if file.file_exists(volume_file):
		file.open(volume_file, File.READ)
		var volume = file.get_var()
		file.close()
		return volume
	else:
		var volume = 1.0
		return volume
