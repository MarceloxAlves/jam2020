extends KinematicBody2D


# Declare member variables here. Examples:
var velocity = Vector2( 100, 0 )
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.slide(collision.normal)
