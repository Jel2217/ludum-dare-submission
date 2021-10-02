extends Camera2D

onready var spos = get_parent().get_parent().get_parent().get_node("ShaderPos")

func _ready():
	pass
	
func _process(_delta):
	spos.position = self.position
