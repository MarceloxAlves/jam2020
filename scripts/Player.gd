extends KinematicBody2D

const MOVE_SPEED = 300
var quant_item = 0
var attack = 10
var sword_life = 100
var break_coefficient = 0.3

var machete
onready var sword_area = $SwordArea
onready var world = get_tree().get_root().get_node("World")

func _ready():
	get_tree().call_group("enemies", "set_player", self)

func _physics_process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	move_vec = move_vec.normalized()
	move_and_collide(move_vec * MOVE_SPEED * delta)
	
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
	
	if Input.is_action_just_pressed("shoot") and sword_area.get_overlapping_areas() != []:	
		var body = sword_area.get_overlapping_areas()[0]
		if (body.name == "ZombieArea2D"):
			attack_enemy(body.get_parent(), attack)

func attack_enemy(body, attack):
	var f = body.take_damage(attack)
	sword_life -= body.sword_damage
	
	if (body.is_dead()):
		print("Matou o inimigo")
		
	f.resume()

func kill():
	get_tree().reload_current_scene()

func pick_up_item():
	quant_item += 1
	world.remove_item()

func equip():
	pass
