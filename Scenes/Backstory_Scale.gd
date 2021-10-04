extends CanvasLayer
var fs_file = "user://fullscreen.save"

func _ready():
	if OS.get_name() == "HTML5" and !load_fs():
		scale = Vector2(640.0/OS.get_screen_size().x, 360.0/OS.get_screen_size().x)
		$Backstory/AnimationPlayer/ColorRect.rect_scale = Vector2(2.25, 2.25)
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
