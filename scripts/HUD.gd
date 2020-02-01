extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var  player =   get_parent().get_node('Player')

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HBoxContainer/VBoxContainer/HP2/PlayerSword.value =player. sword_life

