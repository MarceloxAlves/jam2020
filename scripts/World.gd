extends Node2D

onready var SPAWN_LIMIX_Y = $StaticBody2D/CollisionShape2D.get_position().y

#var quant_max_spawn = 1
var quant_max_spawn = 20
var spawning_time = 3
var spawning_frequency = 2
var quant_item = 0
var enemy_remaing = 0

#var quant_max_spawn_enemy = 6
var quant_max_spawn_enemy = 10
var spawning_time_enemy = 3
var spawning_frequency_enemy = 3
var quant_enemy = 0
var hp = 0
var horda = 1


func _ready():
	var timer = Timer.new()
	timer.set_wait_time(spawning_time)
	timer.set_one_shot(true)
	timer.connect("timeout", self, "repeat_me")
	add_child(timer)
	timer.start()
	
	var timer_enemy = Timer.new()
	timer_enemy.set_wait_time(spawning_time_enemy)
	timer_enemy.set_one_shot(true)
	timer_enemy.connect("timeout", self, "repeate_me_enemy")
	add_child(timer_enemy)
	timer_enemy.start()

func create_timer_enemy():
	var timer_enemy = Timer.new()
	timer_enemy.set_wait_time(spawning_time_enemy)
	timer_enemy.set_one_shot(true)
	timer_enemy.connect("timeout", self, "repeate_me_enemy")
	add_child(timer_enemy)
	timer_enemy.start()
	
func create_timer():
	var timer = Timer.new()
	timer.set_wait_time(spawning_time)
	timer.set_one_shot(true)
	timer.connect("timeout", self, "repeat_me")
	add_child(timer)
	timer.start()
	
func horda_add():
	horda += 1
	quant_max_spawn_enemy += quant_enemy
	get_tree().call_group("enemies", "hordaUp")
	
func repeate_me_enemy():
	
	if (quant_enemy < quant_max_spawn_enemy - spawning_frequency_enemy):
		spawn_enemy()
		
	create_timer_enemy()
	
func spawn_enemy():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	
	var screen_size = get_viewport().get_visible_rect().size
	var enemy = load("res://scenes/Zombie.tscn")

	for i in range(0, spawning_frequency_enemy):
		var spawn = enemy.instance()	
		var x
		var y
		spawn.set_player($Player)
		if (i >= spawning_frequency_enemy / 2):
			x = 30
			y = rand.randf_range(SPAWN_LIMIX_Y + 30, screen_size.y - 30)
		else:
			x = screen_size.x - 50
			y = rand.randf_range(SPAWN_LIMIX_Y + 30, screen_size.y - 30)
		
		spawn.position.x = x
		spawn.position.y = y
		quant_enemy += 1
		enemy_remaing += 1
		
		add_child(spawn)
		
	
func repeat_me():
	if (quant_item < quant_max_spawn - spawning_frequency):
		spawn()
		
	create_timer()

func remove_item():
	quant_item -= 1

func spawn():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	
	var screen_size = get_viewport().get_visible_rect().size
	var item = load("res://scenes/Item.tscn")

	for _i in range(0, spawning_frequency):
		var spawn = item.instance()	
		var x = rand.randf_range(30, screen_size.x - SPAWN_LIMIX_Y)
		var y = rand.randf_range(SPAWN_LIMIX_Y + 30, screen_size.y - 30)
		
		
		spawn.position.x = x
		spawn.position.y = y
		quant_item += 1
		
		add_child(spawn)
		
	spawning_frequency += 1
	quant_max_spawn += 1
	spawning_time += 3
	
	
	
