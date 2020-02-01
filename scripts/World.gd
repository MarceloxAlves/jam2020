extends Node2D

var quant_max_spawn = 3
var spawning_time = 3
var spawning_frequency = 2
var quant_item = 0
var hp = 0

func _ready():
	var timer = Timer.new()
	timer.set_wait_time(spawning_time)
	timer.set_one_shot(true)
	timer.connect("timeout", self, "repeat_me")
	add_child(timer)
	timer.start()


func create_timer():
	var timer = Timer.new()
	timer.set_wait_time(spawning_time)
	timer.set_one_shot(true)
	timer.connect("timeout", self, "repeat_me")
	add_child(timer)
	timer.start()
	
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
	
	
	
