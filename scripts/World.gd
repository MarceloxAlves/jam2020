extends Node2D

var quant_max_spawn = 3
var spawning_time = 3
var spawning_frequency = 2
var quant_item = 0

var quant_max_spawn_enemy = 6
var spawning_time_enemy = 3
var spawning_frequency_enemy = 3
var quant_enemy = 0
var hp = 0


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
	
	
func repeate_me_enemy():
	if (quant_enemy < quant_max_spawn_enemy - spawning_frequency_enemy):
		spawn_enemy()
		
	create_timer_enemy()
	
func spawn_enemy():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	
	var screen_size = get_viewport().get_visible_rect().size
	var enemy = load("res://scenes/Zombie.tscn")

	for _i in range(0, int(spawning_frequency / 2)):
		var spawn = enemy.instance()	
		var x = screen_size.x
		var y = rand.randf_range(30, screen_size.y - 30)
		
		spawn.position.x = x
		spawn.position.y = y
		quant_enemy += 1
		
		add_child(spawn)
		
	for _i in range(0, int(spawning_frequency / 2)):
		var spawn = enemy.instance()	
		var x = 0
		var y = rand.randf_range(30, screen_size.y - 30)
		
		spawn.position.x = x
		spawn.position.y = y
		quant_enemy += 1
		
		add_child(spawn)
		
	#spawning_frequency += 1
	#quant_max_spawn += 1
	#spawning_time += 3
	
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
		var x = rand.randf_range(30, screen_size.x - 30)
		var y = rand.randf_range(30, screen_size.y - 30)
		
		spawn.position.x = x
		spawn.position.y = y
		quant_item += 1
		
		add_child(spawn)
		
	spawning_frequency += 1
	quant_max_spawn += 1
	spawning_time += 3
	
	
	
