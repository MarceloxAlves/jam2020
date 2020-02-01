extends Node2D

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if (body.name == "Player"):
		body.pick_up_item()
		queue_free()
		
	
