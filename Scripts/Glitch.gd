extends AnimationPlayer

var i = 0
var rand = 0
func _ready():
	randomize()
	self.play("Conveyer")
	


func _on_Timer_timeout():
	i = i + 1
	rand = round(rand_range(0,100))
	print(rand)
	if rand >= 70 and i<14 and i>2:
		print("tumble")
		self.play("FallOff")
		i = 14
	if i >= 15:
		queue_free()
	
