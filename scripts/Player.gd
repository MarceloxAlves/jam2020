extends KinematicBody2D

const ENEMY_IMPULSE = 40
var MOVE_SPEED = 600
var quant_item = 0
var attack = 10
var sword_life = 100
var break_coefficient = 0.3
var hp = 100
var hitado = false
var velocity_hit = 0

var x_destiny = 50

var machete
onready var sword_area = $SwordArea
onready var world = get_tree().get_root().get_node("World")

func _ready():
	get_tree().call_group("enemies", "set_player", self)

func _physics_process(delta):
	var press = false
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		$AnimatedSprite.play('walking')
		press = true
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
		$AnimatedSprite.play('walking')
		press = true
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite.play('walking')
		press = true
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite.play('walking')
		press = true
		move_vec.x += 1
	
	if not press:
		$AnimatedSprite.play('idle')
	
	move_vec = move_vec.normalized()
	var _move = move_and_collide(move_vec * MOVE_SPEED * delta)
	
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
	if Input.is_action_just_pressed("shoot"):
		$AnimatedSprite.play('attack')
	
	if Input.is_action_just_pressed("shoot") and sword_area.get_overlapping_areas() != []:	
		var body = sword_area.get_overlapping_areas()[0]
		if (body.name == "ZombieArea2D"):
			attack_enemy(body.get_parent(), attack)
	
	if Input.is_action_just_pressed("shoot") and len(sword_area.get_overlapping_bodies()) > 1:
		var body = sword_area.get_overlapping_bodies()[1]
		
		if (body.name == "Bigorna2D"):
			$bigorna.play()
			sword_repair(body)
		
		#if (body.name == "Zombie"):
		#	if(self.position.x < body.position.x):
		#		body.x_direction = 1
		#	else:
		#		body.x_direction = -1
			
	if (hitado):
		move_and_collide(velocity_hit * ENEMY_IMPULSE * delta)
	
func finish_time():
	hitado = false
	
func attack_enemy(body, damage):
	$attack.play()
	if (sword_life > 0):
		var f = body.take_damage(damage)
		sword_life -= body.sword_damage
		
		
		if (body.is_dead()):
			print("Matou o inimigo")
			
		f.resume()
	
func sword_repair(_body):
	if (quant_item > 0 and sword_life != 100):
		quant_item -= 1
		sword_life += 10
		
func take_hit(damage, velocity):
	hitado = true
		
	var timer = Timer.new()
	timer.set_wait_time(3)
	timer.connect("timeout", self, "finish_time")
	add_child(timer)
	timer.start()
		
	velocity_hit = velocity
	if (hp - damage <= 0):
		hp = 0
		kill()
	hp -= damage

func is_dead():
	return hp == 0

func kill():
	var scene = load("res://scenes/GameOver.tscn")
	var _reload = get_tree().change_scene_to(scene)
	

func pick_up_item():
	quant_item += 1
	$collect.play()
	world.remove_item()

func equip():
	pass

func horda_up():
	if (hp + 25 <= 100):
		hp += 25
	else:
		hp = 100
	MOVE_SPEED += 25 
