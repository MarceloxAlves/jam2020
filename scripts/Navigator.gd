extends Navigation2D


# Declare member variables here. Examples:
# var a = 2
var path = []
signal teste


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path  =  get_simple_path($Zombie.position, $Player.position)
	emit_signal("teste", path)
