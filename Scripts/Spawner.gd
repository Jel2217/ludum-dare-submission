extends Area2D


var slime_blue = preload("res://Scenes/Enemies/BlueSlime.tscn")
var slime_green = preload("res://Scenes/Enemies/GreenSlime.tscn")
var slime_purple = preload("res://Scenes/Enemies/PurpleSlime.tscn")
var slime_red = preload("res://Scenes/Enemies/RedSlime.tscn")
var slime_yellow = preload("res://Scenes/Enemies/YellowSlime.tscn")

export var waves : int
export var blue_slime_amount : int
export var green_slime_amount : int
export var purple_slime_amount : int
export var red_slime_amount : int 
export var yellow_slime_amount : int

var enemy_count = blue_slime_amount + green_slime_amount + purple_slime_amount + red_slime_amount + yellow_slime_amount
var enemy_quota # Every enemy player kills will increase quota - quota == count means wave is over

onready var block_tile_map = $"../BlockTileMap"
var player_in_room = false
var current_wave = 0
var rng = RandomNumberGenerator.new()
var finished = false
func _ready():
	rng.randomize()
	
	set_block_tile_map(false)

func _process(delta):
	if finished: return
	if player_in_room:
		if not get_tree().get_nodes_in_group("enemy"):
			current_wave += 1
			if current_wave > waves:
				player_in_room = false
				set_block_tile_map(false)
				current_wave = 0
			else:
				for i in blue_slime_amount:
					spawn_enemy(slime_blue)
				for i in green_slime_amount:
					spawn_enemy(slime_green)
				for i in purple_slime_amount:
					spawn_enemy(slime_purple)
				for i in red_slime_amount:
					spawn_enemy(slime_red)
				for i in yellow_slime_amount:
					spawn_enemy(slime_yellow)

func _on_Spawner_body_entered(body):
	if body.is_in_group("player"):
		set_block_tile_map(true)
		player_in_room = true
		
func set_block_tile_map(active):
	block_tile_map.set_collision_layer_bit(0, active)
	block_tile_map.set_collision_mask_bit(0, active)
	if active: block_tile_map.show()
	else: block_tile_map.hide()

func spawn_enemy(enemy):
	if not player_in_room: return
	var i = enemy.instance()
	$"../".add_child(i)
	i.position = Vector2(rng.randi_range(position.x, position.x + $CollisionShape2D.position.x * 2),  
	rng.randi_range(position.y, position.y + $CollisionShape2D.position.y * 2)) # Essentially set the position to a random range within the radius of the collision box
