extends HSlider


export var audio_bus_name := "Master"

onready var _bus := AudioServer.get_bus_index(audio_bus_name)


func _ready() -> void:
	value = db2linear(AudioServer.get_bus_volume_db(_bus)) # need to change decibal numbering system effectively to a linear (dc is logarithmic)


func _on_Volume_value_changed(value: float):
	AudioServer.set_bus_volume_db(_bus, linear2db(value))
#	$"../../AudioStreamPlayer".volume_db = linear2db(value)


func _on_Volume_mouse_exited():
	release_focus()
