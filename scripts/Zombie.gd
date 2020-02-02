extends KinematicBody2D

var MOVE_SPEED = 100

var sword_damage = 5
var attack = 10
var hp = 100
var rotation_speed = 90
var velocity = Vector2()
onready var raycast = $RayCast2D
onready var sensorSpider =  $SpiderSensor
onready var area = $ZombieArea2D

var player = null
var path = []

var rand = RandomNumberGenerator.new()
var can_walk = true
	

func _ready():
	add_to_group("enemies")
	rand.randomize()
	
	var timer = Timer.new()
	timer.set_wait_time(rand.randi_range(0, 4))
	timer.connect("timeout", self, "finish_time")
	add_child(timer)
	timer.start()
	

func _physics_process(delta):
	
	if player == null:
		return
	
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	
	if (sensorSpider.is_colliding()):
		var coll = sensorSpider.get_collider()
		if (coll.name != "Player" and area.get_overlapping_bodies() != []):
			velocity = Vector2(MOVE_SPEED, MOVE_SPEED/3).rotated(rotation_speed)
			var _move = move_and_slide(velocity)
		else:
			global_rotation = atan2(vec_to_player.y, vec_to_player.x)
			var _move = move_and_collide(vec_to_player * MOVE_SPEED * delta)
	else:
		if(can_walk):
			global_rotation = atan2(vec_to_player.y, vec_to_player.x)
			var _move = move_and_collide(vec_to_player * MOVE_SPEED * delta)
		
func kill():
	self.get_parent().enemy_remaing -= 1
	queue_free()

func finish_time():
	can_walk = !can_walk
	
func is_dead():
	return hp == 0
	
func take_damage(damage):
	if (hp - damage <= 0):
		hp = 0
		yield()
		kill()
		return

	hp -= damage
	yield()
	return
	
func set_player(p):
	player = p

func hordaUp():
	hp += 50
	MOVE_SPEED += 25

func _on_ZombieArea2D_body_entered(body):
	if body.name == "Player":
		if(self.position.x < body.position.x):
			body.x_destiny = 50
		else:
			body.x_destiny = -50
			
		body.hitado = true
		body.take_hit(attack, player.global_position - global_position)
		


func _on_ZombieArea2D_body_exited(body):
	if body.name == "Player":
		body.hitado = false
