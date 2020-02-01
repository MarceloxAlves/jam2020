extends KinematicBody2D

const MOVE_SPEED = 300
var quant_item = 0
var machete
onready var sword_area = $SwordArea
onready var world = get_tree().get_root().get_node("World")

func _ready():
	get_tree().call_group("zombies", "set_player", self)

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

func kill():
	get_tree().reload_current_scene()

func pick_up_item():
	quant_item += 1
	world.remove_item()

func equip():
	pass

func _on_SwordArea_body_entered(body):
	print(body.name)
	if Input.is_action_pressed("shoot"):
		print("atirou")
	
func _process(delta):
	pass

func _on_SwordArea_area_entered(area):
	print(area.name)
	




func _on_SwordArea_body_shape_entered(body_id, body, body_shape, area_shape):
	print("aqui")
	if Input.is_action_pressed("shoot"):
		print("atirou")
