extends Node2D

var quant = 10


func _ready():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	
	var screen_size = get_viewport().get_visible_rect().size
	var zombie = load("res://scenes/Zombie.tscn")

	
	for i in range(0, int(quant / 4)):
		var spawn = zombie.instance()	
		var x = 0
		var y = rand.randf_range(0, screen_size.y)
		
		spawn.position.x = x
		spawn.position.y = y
		add_child(spawn)
		
	for i in range(0, int(quant / 4)):
		var spawn = zombie.instance()	
		var x = screen_size.x
		var y = rand.randf_range(0,screen_size.y)
		
		spawn.position.x = x
		spawn.position.y = y
		add_child(spawn)

	for i in range(0, int(quant / 4)):
		var spawn = zombie.instance()	
		var x = rand.randf_range(0, screen_size.x)
		var y = 0
		
		spawn.position.x = x
		spawn.position.y = y
		add_child(spawn)
			
	for i in range(0, int(quant / 4)):
		var spawn = zombie.instance()	
		var x = rand.randf_range(0, screen_size.x)
		var y =  screen_size.y 
		
		spawn.position.x = x
		spawn.position.y = y
		add_child(spawn)
