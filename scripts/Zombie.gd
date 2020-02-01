extends KinematicBody2D

const MOVE_SPEED = 100

var sword_damage = 10
var hp = 100
var rotation_speed = 90
var velocity = Vector2()
onready var raycast = $RayCast2D
onready var sensorSpider =  $SpiderSensor
onready var area = $ZombieArea2D

var player = null
var path = []

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
	
	if player == null:
		return
	
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	
	if (sensorSpider.is_colliding()):
		var coll = sensorSpider.get_collider()
		if (coll.name != "Player" and area.get_overlapping_bodies() != []):
			velocity = Vector2(MOVE_SPEED, MOVE_SPEED/3).rotated(rotation_speed)
			var move = move_and_slide(velocity)
		else:
			global_rotation = atan2(vec_to_player.y, vec_to_player.x)
			move_and_collide(vec_to_player * MOVE_SPEED * delta)
	else:
		global_rotation = atan2(vec_to_player.y, vec_to_player.x)
		move_and_collide(vec_to_player * MOVE_SPEED * delta)
		
		
	
	
	
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.kill()
						

func kill():
	queue_free()

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

#func is_dead = hp
