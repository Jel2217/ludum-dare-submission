extends CanvasLayer
var fs_file = "user://fullscreen.save"


	
func _process(_delta):
	print(OS.get_screen_size())
	
func load_fs():
	var file = File.new()
	if file.file_exists(fs_file):
		file.open(fs_file, File.READ)
		var fs = file.get_var()
		file.close()
		return fs
	else:
		var fs = false
		return fs

