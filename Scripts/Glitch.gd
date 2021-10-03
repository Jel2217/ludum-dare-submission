extends AnimationPlayer

export var glitch_card_num = 7
onready var card_texture = $TextureRect/MarginContainer/TextureRect
onready var crumble = $TextureRect/MarginContainer/Crumble
var i = 0
var rand = 0
var texture

func _ready():
	randomize()
	var card = round(rand_range(1,glitch_card_num))
	#TODO - add unknown card feature
	var img = Image.new()
	var itex = ImageTexture.new()
	if card == 1:
		img.load("res://Images/Glitch Cards/corner-explosion.png")
		img.resize(20,20,0)
	elif card == 2:
		img.load("res://Images/Glitch Cards/fat.png")
		img.resize(20,20,0)
	elif card == 3:
		img.load("res://Images/Glitch Cards/hooded-figure.png")
		img.resize(20,20,0)
	elif card == 4:
		img.load("res://Images/Glitch Cards/pc.png")
		img.resize(20,20,0)
	elif card == 5:
		img.load("res://Images/Glitch Cards/slime.png")
		img.resize(20,20,0)
	elif card == 6:
		img.load("res://Images/Glitch Cards/teleport.png")
		img.resize(20,20,0)
	elif card == 7:
		img.load("res://Images/Glitch Cards/whirlwind.png")
		img.resize(20,20,0)
	itex.create_from_image(img)
	card_texture.set_texture(itex)
	self.play("Conveyer")
	


func _on_Timer_timeout():
	i = i + 1
	rand = round(rand_range(0,75))
	if rand == 1   and i<130 and i>20:
		self.play("FallOff")
		crumble.set_emitting(true)
		i = 140
	if i >= 150:
		queue_free()
	
