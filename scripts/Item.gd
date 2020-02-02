extends Node2D

var collected = false
onready var Hitem = get_parent().get_node_or_null('HUD')
var positionNext = Vector2(0,0)
var energy_max = 0.3

func _ready():
	positionNext =  Vector2(get_viewport().get_visible_rect().size.x - 50, 50)
	set_process(true)
	$Tween.interpolate_property($Light2D, 'energy', null, energy_max, 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()
		
	
func _process(delta):
	if collected:
		self.position =  	self.position.linear_interpolate(positionNext, delta * 4)
		if self.position.distance_to(positionNext) < 100:
			queue_free()
		
func _on_Area2D_body_entered(body):
	if (body.name == "Player"):
		body.pick_up_item()
		collected = true
		#queue_free()
		
	


func _on_Tween_tween_all_completed():
	$Tween2.interpolate_property($Light2D, 'energy', null, 0, 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween2.start()


func _on_Tween2_tween_all_completed():
	$Tween.interpolate_property($Light2D, 'energy', null, energy_max, 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()
