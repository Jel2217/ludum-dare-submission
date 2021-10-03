extends Area2D


var slime_blue = preload("res://Scenes/Enemies/BlueSlime.tscn")
var slime_green = preload("res://Scenes/Enemies/GreenSlime.tscn")
var slime_purple = preload("res://Scenes/Enemies/PurpleSlime.tscn")
var slime_red = preload("res://Scenes/Enemies/RedSlime.tscn")
var slime_yellow = preload("res://Scenes/Enemies/YellowSlime.tscn")

export var waves = 1
export var blue_slime_amount = 0
export var green_slime_aomunt = 0
export var purple_slime_aomunt = 0
export var red_slime_aomunt = 0
export var yellow_slime_aomunt = 0

var enemy_count = blue_slime_amount + green_slime_aomunt + purple_slime_aomunt + red_slime_aomunt + yellow_slime_aomunt
var enemy_quota # Every enemy player kills will increase quota - quota == count means wave is over

onready var block_tile_map = $"../BlockTileMap"
var player_in_room = false

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	
	set_block_tile_map(false)

func _on_Spawner_body_entered(body):
	if body.is_in_group("player"):
		set_block_tile_map(true)
		player_in_room = true
		
func set_block_tile_map(active):
	block_tile_map.set_collision_layer_bit(0, active)
	block_tile_map.set_collision_mask_bit(0, active)
	if active: block_tile_map.show()
	else: block_tile_map.hide()

func _physics_process(delta):
	if not player_in_room: return
	var i = slime_blue.instance()
	$"../".add_child(i)
	i.position = Vector2(rng.randi_range(position.x, position.x + $CollisionShape2D.position.x * 2),  
	rng.randi_range(position.y, position.y + $CollisionShape2D.position.y * 2)) # Essentially set the position to a random range within the radius of the collision box
	
	
