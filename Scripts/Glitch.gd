extends AnimationPlayer

export var glitch_card_num = 8
onready var card_texture = $TextureRect/MarginContainer/TextureRect
onready var crumble = $TextureRect/MarginContainer/Crumble
onready var glitch_fx = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("GlitchFX")
var i = 0
var rand = 0
var texture
var card

func _ready():
	randomize()
	card = round(rand_range(1,glitch_card_num))
	#TODO - add unknown card feature
	var img = Image.new()
	var itex = ImageTexture.new()
	if card == 1:
		img.load("res://Images/Glitch Cards/Card8.png")
#		img.resize(20,20,0)
	elif card == 2:
		img.load("res://Images/Glitch Cards/Card9.png")
#		img.resize(20,20,0)
	elif card == 3:
		img.load("res://Images/Glitch Cards/Card6.png")
#		img.resize(20,20,0)
	elif card == 4:
		img.load("res://Images/Glitch Cards/Card7.png")
#		img.resize(20,20,0)
	elif card == 5:
		img.load("res://Images/Glitch Cards/Card5.png")
#		img.resize(20,20,0)
	elif card == 6:
		img.load("res://Images/Glitch Cards/Card3.png")
#		img.resize(20,20,0)
	elif card == 7:
		img.load("res://Images/Glitch Cards/Card2.png")
#		img.resize(20,20,0)
	elif card == 8:
		img.load("res://Images/Glitch Cards/Card1.png")
#		img.resize(20,20,0)
	itex.create_from_image(img)
	card_texture.set_texture(itex)
	self.play("Conveyer")
	


func _on_Timer_timeout():
	randomize()
	i = i + 1
	rand = round(rand_range(0,65))
	if rand == 1   and i<130 and i>20:
		self.play("FallOff")
		crumble.set_emitting(true)
		if card == 1:
			glitch_fx.explosions()
		elif card == 2:
			glitch_fx.fat()
		elif card == 3:
			glitch_fx.invis()
		elif card == 4:
			var effect = floor(rand_range(1,3))
			if effect == 1:
				glitch_fx.invert()
			elif effect == 2:
				glitch_fx.normalise()
			elif effect == 3:
				glitch_fx.deepfried()
		elif card == 5:
				#glitch_fx.enemy()
				glitch_fx.heal()
		elif card == 6:
				#glitch_fx.teleport()
				glitch_fx.poisin()
		elif card == 7:
				glitch_fx.whirl()
		elif card == 8:
				glitch_fx.wave()
		
		i = 140
	if i >= 150:
		queue_free()
	
