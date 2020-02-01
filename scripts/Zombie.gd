extends KinematicBody2D

const MOVE_SPEED = 100

onready var raycast = $RayCast2D
onready var sensorSpider =  $SpiderSensor

var player = null

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
	if player == null:
		return
	
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	#global_rotation = atan2(vec_to_player.y, vec_to_player.x)
	move_and_collide(vec_to_player * MOVE_SPEED * delta)
	
	if sensorSpider.is_colliding():
		var coll = sensorSpider.get_collider()
		if coll.name != "Player":
				print("bateu")
	
	
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.kill()

func kill():
	queue_free()

func set_player(p):
	player = p
