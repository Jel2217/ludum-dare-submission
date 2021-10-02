extends AnimationPlayer

var i = 0
var rand = 0
func _ready():
	randomize()
	self.play("Conveyer")
	


func _on_Timer_timeout():
	i = i + 1
	rand = round(rand_range(0,50))
	print(rand)
	if rand == 1   and i<130 and i>20:
		print("tumble")
		self.play("FallOff")
		i = 140
	if i >= 150:
		queue_free()
	
